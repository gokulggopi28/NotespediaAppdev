import 'package:dio/dio.dart';
import 'package:notespedia/utils/constants/app_export.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pay/pay.dart';

import '../../detailed/add_address_screen.dart';
import '../../detailed/controller/address_controller.dart';
import '../../home/fragment/payment_webview.dart';
import '../controller/promo_code_controller.dart';

class CartBottomSheet extends StatelessWidget {
  CartBottomSheet({
    super.key,
  });

  final auController = Get.find<AuthenticationController>();
  final ctController = Get.find<CartAndOrderController>();

  final CartAndOrderController cartAndOrderController =
      Get.find<CartAndOrderController>();

  @override
  Widget build(BuildContext context) {
    final PromoCodeController promoCodeController =
        Get.put(PromoCodeController());
    Get.put(AddressesController());
    final CartAndOrderController cartAndOrderController =
        Get.find<CartAndOrderController>();
    final AuthenticationController authController =
        Get.find<AuthenticationController>();
    return Obx(() {
      final hasPriceData = ctController.priceCalculationData.isNotEmpty;
      final subTotalAmount = hasPriceData
          ? "₹ ${ctController.priceCalculationData.first.subTotalAmount}"
          : "N/A";
      final taxAmount = hasPriceData
          ? "₹ ${ctController.priceCalculationData.first.taxAmount}"
          : "N/A";
      final discountAmount = hasPriceData
          ? "₹ ${ctController.priceCalculationData.first.discountAmount}"
          : "N/A";
      final orderTotal = hasPriceData
          ? "₹ ${ctController.priceCalculationData.first.orderTotal}"
          : "N/A";

      return Visibility(
        visible: auController.isLoggedIn.isTrue ? true : false,
        child: Material(
          elevation: 12,
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26.0),
              topRight: Radius.circular(26.0),
            ),
          ),
          child: Container(
            height: DeviceHelper.getScreenHeight(context) * .44,
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            height: 0,
                          ),
                    ),
                    Text(
                      "₹ ${subTotalAmount}",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            height: 0,
                          ),
                    ),
                  ],
                ),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tax",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            height: 0,
                          ),
                    ),
                    Text(
                      "₹ ${taxAmount}",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            height: 0,
                          ),
                    ),

                    // Text(
                    //   "Discount",
                    //   textAlign: TextAlign.center,
                    //   maxLines: 1,
                    //   style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: 18,
                    //         height: 0,
                    //       ),
                    // ),
                    // Text(
                    //   "₹ ${ctController.priceCalculationData.first.discountAmount}",
                    //   textAlign: TextAlign.center,
                    //   maxLines: 1,
                    //   style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: 18,
                    //         height: 0,
                    //       ),
                    // ),
                    // Text(
                    //   "Grand Total",
                    //   textAlign: TextAlign.center,
                    //   maxLines: 1,
                    //   style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: 18,
                    //         height: 0,
                    //       ),
                    // ),
                    // Text(
                    //   "₹ ${ctController.priceCalculationData.first.orderTotal}",
                    //   textAlign: TextAlign.center,
                    //   maxLines: 1,
                    //   style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: 18,
                    //         height: 0,
                    //       ),
                    // ),
                  ],
                ),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Discount",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            height: 0,
                          ),
                    ),
                    Text(
                      "₹ ${discountAmount}",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            height: 0,
                          ),
                    ),
                  ],
                ),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Grand Total",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            height: 0,
                          ),
                    ),
                    Text(
                      "₹ ${orderTotal}",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            height: 0,
                          ),
                    ),
                  ],
                ),
                const Gap(10),
                // Divider(color: Colors.grey.shade200, height: 1.5),
// Inside your CartBottomSheet build method, after the Gap(16)
                Obx(() {
                  String appliedCouponCode =
                      promoCodeController.appliedCoupon.value;
                  return Visibility(
                    visible: appliedCouponCode.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Applied Coupon: $appliedCouponCode',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Clear the applied coupon
                              promoCodeController.clearCoupon();
                              // Refetch price details with the coupon removed
                              ctController.fetchThePriceDetails();
                            },
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(
                                color: Colors.red, // Text color
                              ),
                            ),
                            child: Text(
                              "Clear Coupon",
                              style: TextStyle(
                                color: Color(0xFF05CF64), // Text color
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Promo Code',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(26.0)),
                          ),
                          builder: (BuildContext context) {
                            // Initialize the controller if not already done
                            final promoCodeController =
                                Get.find<PromoCodeController>();

                            return DraggableScrollableSheet(
                              expand: false,
                              initialChildSize:
                                  0.9, // Start at 90% of screen height
                              minChildSize:
                                  0.5, // Minimum size at 50% of screen height
                              maxChildSize: 1.0,
                              builder: (_, scrollController) => Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 16.0),
                                child: Column(
                                  children: [
                                    AppBar(
                                      leading: IconButton(
                                        icon: Icon(Icons.chevron_left,
                                            color: Colors.black),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                      title: Text("Promo Code",
                                          style:
                                              TextStyle(color: Colors.black)),
                                      backgroundColor: Colors.white,
                                      elevation: 1,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 16.0, bottom: 8.0),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: "Enter Promo Code",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              ctController
                                                  .fetchThePriceDetails();
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15.0,
                                                  horizontal: 12.0),
                                              child: Text(
                                                "APPLY",
                                                style: TextStyle(
                                                  color: Color(0xFF05CF64),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Available Coupons",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Obx(() {
                                        if (promoCodeController
                                            .isLoading.isTrue) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (promoCodeController
                                            .promoCodes.isEmpty) {
                                          return Text("No data");
                                        } else {
                                          return ListView.builder(
                                            controller: scrollController,
                                            itemCount: promoCodeController
                                                .promoCodes.length,
                                            itemBuilder: (context, index) {
                                              var offer = promoCodeController
                                                  .promoCodes[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      offer['coupon_title'],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    SizedBox(height: 6),
                                                    Text(
                                                      "Get ${offer['discount_percentage']}% off",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black
                                                            .withOpacity(0.8),
                                                      ),
                                                    ),
                                                    SizedBox(height: 6),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(4),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFF05CF64),
                                                                style:
                                                                    BorderStyle
                                                                        .solid),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                          child: Text(
                                                            offer[
                                                                'coupon_code'],
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF05CF64),
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            promoCodeController
                                                                .applyCoupon(
                                                                    offer[
                                                                        'coupon_code'],
                                                                    offer[
                                                                        'id']);
                                                            await ctController
                                                                .fetchThePriceDetails();
                                                            Get.back(); // Close the bottom sheet
                                                          },
                                                          child: Text(
                                                            "APPLY",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF05CF64),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      style: TextButton.styleFrom(
                        alignment: Alignment.centerRight,
                      ),
                      child: Text(
                        'View Coupons',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: const Color(0xFF6AC997),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ReusableMaterialButton(
                  onPressed: () async {
                    if (authController.isLoggedIn.isTrue) {
                      // Check if the address list is empty
                      final AddressesController addressesController =
                          Get.find<AddressesController>();
                      if (addressesController.addresses.isEmpty) {
                        // Navigate to AddNewAddressScreen to add an address
                        print(
                            "Navigating to AddNewAddressScreen because address list is empty");
                        // HelperFunctions.showTopSnackBar(
                        //   context: context,
                        //   title: "No Addresses Yet",
                        //   message: "Please add an Address to continue",
                        // );
                        final result =
                            await Get.to(() => AddNewAddressScreen());
                        print(
                            "Back from AddNewAddressScreen with result: $result");
                        // Optionally re-check the address list after returning from AddNewAddressScreen
                        if (addressesController.addresses.isEmpty) {
                          // Now that an address has been added, you can proceed with the original functionality
                          String? checkoutUrl = await cartAndOrderController
                              .createOrderAndFetchUrl();
                          if (checkoutUrl != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PaymentWebViewScreen(
                                    paymentUrl: checkoutUrl)));
                          } else {
                            HelperFunctions.showTopSnackBar(
                              context: context,
                              title: "Error",
                              message: "Order creation failed",
                            );
                          }
                        }
                      } else {
                        // Address list is not empty, proceed with the original order now functionality
                        String? checkoutUrl = await cartAndOrderController
                            .createOrderAndFetchUrl();
                        if (checkoutUrl != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PaymentWebViewScreen(
                                  paymentUrl: checkoutUrl)));
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
                  color: AppColors.brightGreen,
                  child: Text(
                    'Proceed to Payment',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Gap(DeviceHelper.getBottomNavigationBarHeight()),
              ],
            ),
          ),
        ),
      );
    });
  }
}
