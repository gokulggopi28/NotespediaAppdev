import 'package:notespedia/utils/constants/app_export.dart';

import '../../features/detailed/add_address_screen.dart';
import '../../features/detailed/controller/address_controller.dart';
import '../../features/home/fragment/payment_webview.dart';

class BookPurchaseButton extends StatelessWidget {
  const BookPurchaseButton({
    Key? key,
    required this.controller,
    required this.bookId,
  }) : super(key: key);

  final BookDetailData controller;
  final int bookId;

  @override
  Widget build(BuildContext context) {
    Get.put(AddressesController());
    final CartAndOrderController cartAndOrderController =
        Get.find<CartAndOrderController>();
    final AuthenticationController authController =
        Get.find<AuthenticationController>();

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.brightGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get Hardcopy',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    "₹ ${controller.hardCopyOldPrice}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "₹ ${controller.hardCopyNewPrice}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          TextButton(
            onPressed: () async {
              if (authController.isLoggedIn.isTrue) {
                // Check if the address list is empty
                final AddressesController addressesController =
                    Get.find<AddressesController>();
                if (addressesController.addresses.isEmpty) {
                  // Navigate to AddNewAddressScreen to add an address
                  print(
                      "Navigating to AddNewAddressScreen because address list is empty");
                  HelperFunctions.showTopSnackBar(
                    context: context,
                    title: "No Addresses Yet",
                    message: "Please add an Address to continue",
                  );
                  final result = await Get.to(() => AddNewAddressScreen());
                  print("Back from AddNewAddressScreen with result: $result");
                  // Optionally re-check the address list after returning from AddNewAddressScreen
                  if (addressesController.addresses.isEmpty) {
                    // Now that an address has been added, you can proceed with the original functionality
                    String? checkoutUrl = await cartAndOrderController
                        .createOrderAndFetchUrforOrder(bookId);
                    if (checkoutUrl != null) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PaymentWebViewScreen(paymentUrl: checkoutUrl)));
                    } else {
                      // Handle error, e.g., show an error message
                    }
                  }
                } else {
                  // Address list is not empty, proceed with the original order now functionality
                  String? checkoutUrl = await cartAndOrderController
                      .createOrderAndFetchUrforOrder(bookId);
                  if (checkoutUrl != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            PaymentWebViewScreen(paymentUrl: checkoutUrl)));
                  } else {
                    // Handle error, e.g., show an error message
                  }
                }
              } else {
                // User is not logged in, show login prompt and navigate to sign-in page
                HelperFunctions.showTopSnackBar(
                  context: context,
                  title: "Status Message",
                  message: "Please Login",
                );
                Get.toNamed(AppRoutes.signInMobileRoute);
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              primary: AppColors.brightGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Order Now',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
