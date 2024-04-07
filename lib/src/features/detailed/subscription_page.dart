import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/models/store_product_wrapper.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../../models/subscription_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/app_export.dart';
import '../home/controller/subscription_controller.dart';
import '../navigation/home_screen.dart';
import '../navigation/navigationController.dart';
import 'in_app_subscription.dart';

class PremiumPlansPage extends StatefulWidget {
  @override
  _PremiumPlansPageState createState() => _PremiumPlansPageState();
}

class _PremiumPlansPageState extends State<PremiumPlansPage> {
  late Future<Plan> futurePlan;
  SubscriptionScheme? selectedScheme;
  //late Razorpay _razorpay;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  late final InAppSubscription _inAppSubscription;

  @override
  void initState() {
    super.initState();
    futurePlan = fetchPlans();
    // _razorpay = Razorpay();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    // _razorpay.clear(); // Removes all listeners
    _subscription.cancel();
  }

  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text("Payment successful, ID: ${response.paymentId}")),
  //   );
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text("Payment failed: ${response.message}")),
  //   );
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text("External Wallet: ${response.walletName}")),
  //   );
  // }
  Future<void> createDummySubscription(
      int userId, int planId, int schemeId) async {
    final Dio dio = Dio(); // Consider reusing Dio instance across your app
    final String apiUrl =
        "${ApiConstants.baseUrl}/checkout/create_subscription/";
    final String purchaseToken =
        "2342323213323423"; // Replace with actual token

    final requestData = {
      'user_id': userId,
      'plan_id': planId,
      'subscription_scheme_id': schemeId,
      'os_type': Platform.isIOS ? "ios" : "android",
      'purchase_token': purchaseToken,
    };
    print("Request data: $requestData");

    try {
      final response = await dio.post(apiUrl, data: requestData);
      print("Response data: ${response.data}");
      if (response.statusCode == 200) {
        // API call is successful, show success popup without OK button
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Successfully Subscribed'),
          ),
          barrierDismissible: false,
        );

        // Wait for 3 seconds and then automatically close the dialog and navigate to the homepage
        Future.delayed(Duration(seconds: 6), () {
          Navigator.of(context).pop(); // Close the dialog
          Get.find<NavigationController>()
              .changeIndex(0); // Set selectedIndex to 3
          Get.to(() => HomeScreen());
        });
      } else {
        // Handle non-successful response
        print('Failed to create subscription: ${response.data}');
      }
    } catch (e) {
      print(e);
      // Handle error, possibly show an error dialog
    }
  }

  Future<void> createSubscription(
      int userId, int planId, int schemeId, String purchaseToken) async {
    final requestData = {
      'user_id': userId,
      'plan_id': planId,
      'subscription_scheme_id': schemeId,
      'os_type': Platform.isIOS ? "ios" : "android",
      'purchase_token': purchaseToken,
    };
    try {
      final response = await Dio().post(
        'https://notespaedia.deienami.com/api/checkout/create_subscription/',
        data: requestData,
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null && data.containsKey('order_id')) {
          final String orderId = data['order_id'];
          final int amount = data[
              'checkout_amount']; // Make sure to handle the amount correctly
          //startPayment(orderId, amount);
          Navigator.pop(context);
        } else {
          print('Order ID is not available.');
        }
      } else {
        print('Failed to create subscription');
      }
    } catch (e) {
      print(e);
    }
  }

  // void startPayment(String orderId, int amount) {
  //   var options = {
  //     'key': 'rzp_test_52bSZC7E6MwuIR',
  //     'amount':
  //         amount, // Amount is expected to be in the smallest unit (e.g., paise for INR).
  //     'name': 'Subscription',
  //     'description': 'Premium Plan Subscription',
  //     'order_id': orderId,
  //     'prefill': {
  //       'contact': '8921776332',
  //       'email': 'sajinjoseph0202@gmail.com'
  //     },
  //   };
  //   try {
  //     _razorpay.open(options);
  //   } catch (e) {
  //     debugPrint('Error: $e');
  //   }
  // }

  void _showPendingUI() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("Loading"),
            ],
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Check if it's possible to pop the current route.
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(); // Pop the current route.
            return false; // Prevent the system from popping the route, as we've handled it manually.
          }
          return true; // Allow the system to handle the back button (e.g., exiting the app) if no routes to pop.
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text("Subscriptions"),
          ),
          body: FutureBuilder<Plan>(
            future: futurePlan,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }

              Plan plan = snapshot.data!;
              return Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              const SizedBox(height: 107),
                              Center(
                                child: Image.asset(
                                  'assets/images/png/verified.png',
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "PREMIUM PLAN",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              SubscriptionScheme scheme =
                                  plan.subscriptionSchemes[index];
                              bool isSelected = scheme.id == (selectedScheme?.id ?? 0);

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedScheme = plan.subscriptionSchemes[index];
                                  });
                                },
                                child: Card(
                                  color: isSelected
                                      ? Colors.lightGreen
                                      : Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    "₹${scheme.subscriptionAmount} / ",
                                                style: const TextStyle(
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                              TextSpan(
                                                text: scheme.durationLabel,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "• ${scheme.description}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: plan.subscriptionSchemes.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width:
                          double.infinity, // Takes the full width of the parent
                      height: 52,
                      child: ElevatedButton(
                        onPressed: selectedScheme != null
                            ? () async {
                          getPackages(selectedScheme!.id, selectedScheme!.productId);
                        }
                        : null, // Disable button if no scheme is selected
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF05CF64), // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Text(
                          "Activate Plan",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }

  Future<void> getPackages(int selectedSchemeID, String productID) async {

    List<StoreProduct>? storeProducts;
    if (Platform.isIOS) {
      try {
        storeProducts = await Purchases.getProducts(['com.notespaedia.npyearlysubscription', 'yearlysubscription_neetpg']);
        StoreProduct? selectedProduct;
        selectedProduct = storeProducts.firstWhere((element) => element.identifier == productID);
        _showPendingUI();
        CustomerInfo info = await Purchases.purchaseStoreProduct(selectedProduct!);
        int userId = UserPreferences.userId;
        await createSubscription(userId, 18, selectedScheme!.id,
            info.originalAppUserId);
      } on PlatformException catch(e) {
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text("Error"),
              content: Text("Unexpected Error"),
              actions: <Widget>[
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            ));
      }

    } else {
      try {

        storeProducts = await Purchases.getProducts(['npquarterlysubscription',
          'nphalfyearlysubscription', 'npyearlysubscription']);
        StoreProduct? _selectedProduct;
        _selectedProduct = storeProducts.firstWhere(
                (element) => element.identifier == 'npquarterlysubscription');
        _showPendingUI();
        CustomerInfo info = await Purchases.purchaseStoreProduct(_selectedProduct);
      } on PlatformException catch(e) {
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text("Error"),
              content: Text("Unexpected Error"),
              actions: <Widget>[
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            ));
      }
    }
  }

}
