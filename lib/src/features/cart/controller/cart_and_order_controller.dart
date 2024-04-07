import 'dart:convert';

import 'package:notespedia/models/cart_item_model.dart';
import 'package:notespedia/models/order_detail_model.dart';
import 'package:notespedia/models/order_list_model.dart';
import 'package:notespedia/models/price_calculation_model.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import 'package:notespedia/utils/constants/app_export.dart';
import 'package:pay/pay.dart';

import 'promo_code_controller.dart';

class CartAndOrderController extends GetxController {
  //
  final networkStateController = Get.find<NetworkStateController>();
  final authController = Get.find<AuthenticationController>();

  var isProcessing = false.obs;
  var hasError = false.obs;

  var isOrderProcessing = false.obs;
  var hasOrderError = false.obs;

  var cartItemList = <CartItemList>[].obs;
  var priceCalculationData = <PriceCalculationModel>[].obs;

  var orderItemList = <OrderList>[].obs;
  var orderDetailList = <OrderDetailList>[].obs;
  var cartOrderList = <BookDetailData>[].obs;

  @override
  void onInit() {
    fetchTheItemInCart();

    fetchTheOrderList();
    fetchThePriceDetails();
    super.onInit();
  }

  @override
  void onReady() {}

  Future<void> onTapOnCartAction({
    required BuildContext ctx,
    required int selectedBookId,
  }) async {
    if (networkStateController.isInternetConnected.isTrue) {
      await createItemInCart(ctx: ctx, selectedBookId: selectedBookId);
      await fetchTheItemInCart();
      await fetchThePriceDetails();
    } else {
      HelperFunctions.showSnackBar(
        context: ctx,
        message: "No Internet Connection",
      );
    }
  }

  Future<void> fetchOrderDetails(int orderId) async {
    try {
      final response = await HttpService.dioGetRequest(
        url: "${ApiConstants.baseUrl}order/order_detail/",
        queryParameters: {"order_id": orderId},
      );

      if (response.statusCode == 200) {
        final OrderDetailModel orderDetailModel =
            orderDetailModelFromJson(jsonEncode(response.data));
        // Use orderDetailModel.listData here, not orderDetailModel directly
        OrderDetailList orderDetailList = orderDetailModel.listData;
        // Now, you can use orderDetailList in your UI
      } else {
        print('Failed to fetch order details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching order details: $e');
    }
  }

  Future<void> fetchTheItemInCart({
    BuildContext? ctx,
  }) async {
    if (authController.isLoggedIn.isTrue && authController.isUserId > 0) {
      try {
        isProcessing(true);
        hasError(false);
        final response = await HttpService.dioGetRequest(
          url: "${ApiConstants.baseUrl}cart/cart_item/",
          queryParameters: {"user_id": UserPreferences.userId},
        );

        if (response.statusCode == 200) {
          final jsonData = cartItemModelFromJson(json.encode(response.data));
          print("API Data: ${jsonData.cartData}");
          cartItemList.assignAll(jsonData.cartData);
        } else {
          print("Failed to fetch items. Status code: ${response.statusCode}");
        }
      } catch (error) {
        hasError(true);
        DebugLogger.error(error.toString());
      } finally {
        isProcessing(false);
      }
    } else {
      return;
    }
  }

  Future<void> updateCartItem({
    required BuildContext ctx,
    required int id,
    required int cartId,
    required int bookId,
    required int quantity,
    String bookType = "soft_copy",
  }) async {
    if (!authController.isLoggedIn.isTrue ||
        authController.isUserId.value <= 0) {
      HelperFunctions.showTopSnackBar(
        context: ctx,
        title: "Status Message",
        message: "Please Login",
      );
      Get.toNamed(AppRoutes.signInMobileRoute);
      return;
    }

    try {
      final response = await HttpService.dioPutRequest(
        url: "${ApiConstants.baseUrl}cart/cart_item/$id/",
        data: {
          "cart_id": cartId,
          "book_id": bookId,
          "quantity": quantity,
          "book_type": bookType,
        },
      );

      if (response.statusCode == 200) {
        HelperFunctions.showTopSnackBar(
          context: ctx,
          title: "Success",
          message: "Cart item updated successfully",
        );
        await fetchTheItemInCart(ctx: ctx);
        // Optionally refresh the cart list here
        await fetchTheItemInCart();
        await fetchThePriceDetails();
      } else {
        print(
            "Failed to update cart item. Status code: ${response.statusCode}");
      }
    } catch (error) {
      DebugLogger.error("Exception: $error");
      HelperFunctions.showTopSnackBar(
        context: ctx,
        title: "Error",
        message: "Failed to update cart item",
      );
    }
  }

  Future<void> fetchThePriceDetails({
    BuildContext? ctx,
  }) async {
    Get.put(PromoCodeController());
    var promoCodeController = Get.find<PromoCodeController>();
    String? couponCode = promoCodeController.appliedCoupon.value.isNotEmpty
        ? promoCodeController.appliedCoupon.value
        : null;
    String? couponId = promoCodeController.appliedCouponId.value.isNotEmpty
        ? promoCodeController.appliedCouponId.value
        : null;

    var requestData = {
      "user_id": UserPreferences.userId,
      "coupon_code": couponCode,
      "coupon_id": couponId,
    };

    // Print the data being sent to the API
    print('Request data for price fetching : $requestData');

    if (authController.isLoggedIn.isTrue && authController.isUserId > 0) {
      try {
        final response = await HttpService.dioPostRequest(
          url: "${ApiConstants.baseUrl}cart/order_summary/",
          data: requestData,
        );

        // Print the raw response from the API  print('Response data for price fetching : ${response.data}');

        if (response.statusCode == 200) {
          final jsonData =
              priceCalculationModelFromJson(json.encode(response.data));
          priceCalculationData.assignAll([jsonData]);
        }
      } catch (error) {
        DebugLogger.error(error.toString());
        // Print the error if the request fails
        print('Error fetching price details: $error');
      }
    } else {
      return;
    }
  }

  // Future<void> createOrder() async {
  //   int userId = UserPreferences.userId;
  //   var orderTotal = priceCalculationData.first.orderTotal;
  //   var orderItems = cartItemList.map((item) {
  //     return {
  //       "book_id": item.bookId,
  //       "book_type": 1, // Assuming the book type is always 1
  //       "quantity": 1, // Assuming the quantity is always 1
  //       "book_sub_total_amount": item.bookPrice.toString()
  //     };
  //   }).toList();

  //   var data = {
  //     "user_id": userId,
  //     "payment_method_id": 1,
  //     "coupon_id": "0",
  //     "sub_total_amount": orderTotal,
  //     "discount_amount": "0",
  //     "tax_amount": "0",
  //     "total_amount": orderTotal,
  //     "address_id": 2, // Assuming a static value for address_id
  //     "order_items": orderItems
  //   };

  //   print('Sending data: $data');

  //   try {
  //     final response = await HttpService.dioPostRequest(
  //       url: "${ApiConstants.baseUrl}order/create_order/",
  //       data: data,
  //     );

  //     if (response.statusCode == 201) {
  //       print('Order created successfully: ${response.data}');
  //     } else {
  //       print(
  //           'Error creating order: ${response.statusCode} - ${response.data}');
  //     }
  //   } catch (e) {
  //     print('Exception occurred while creating order: $e');
  //   }
  // }

  Future<void> fetchBookDetails(int bookId) async {
    var existingDetail = cartOrderList.any((detail) => detail.bookId == bookId);

    if (existingDetail == false) {
      try {
        final response = await HttpService.dioGetRequest(
            url: "${ApiConstants.baseUrl}books/books/$bookId");

        if (response.statusCode == 200) {
          final jsonData = bookDetailsModelFromJson(json.encode(response.data));
          cartOrderList.add(jsonData.bookDetailData);
        } else {
          DebugLogger.warning(
              'Failed to fetch book details: ${response.statusCode}');
        }
      } catch (error) {
        DebugLogger.error("Exception: $error");
      }
    }
  }

  Future<void> createItemInCart({
    required BuildContext ctx,
    required int selectedBookId,
  }) async {
    if (authController.isLoggedIn.isTrue && authController.isUserId.value > 0) {
      try {
        final response = await HttpService.dioPostRequest(
          url: "${ApiConstants.baseUrl}cart/cart_item/",
          data: {
            "book_id": selectedBookId,
            "user_id": UserPreferences.userId,
            "book_type": "hard_copy",
            "quantity": 1
          },
        );

        if (response.statusCode == 200) {
          HelperFunctions.showTopSnackBar(
            context: ctx,
            title: "Status Message",
            message: "Add to cart Succesfully",
          );
        }
      } catch (error) {
        DebugLogger.error("Exception: $error");
      }
    } else {
      HelperFunctions.showTopSnackBar(
        context: ctx,
        title: "Status Message",
        message: "Please Login",
      );

      Get.toNamed(AppRoutes.signInMobileRoute);
    }
  }

  Future<void> deleteItemInCart({
    required BuildContext ctx,
    required int selectedItemId,
  }) async {
    if (authController.isLoggedIn.isTrue && authController.isUserId > 0) {
      try {
        isOrderProcessing(true);
        hasOrderError(false);
        final response = await HttpService.dioDeleteRequest(
          url: "${ApiConstants.baseUrl}cart/cart_item/$selectedItemId/",
        );

        if (response.statusCode == 200) {
          fetchTheItemInCart();
          fetchThePriceDetails();
        }
      } catch (error) {
        hasOrderError(true);
        DebugLogger.error(error.toString());
      } finally {
        isOrderProcessing(false);
      }
    } else {
      return;
    }
  }

  Future<void> fetchTheOrderList({BuildContext? context}) async {
    if (authController.isLoggedIn.isTrue && authController.isUserId > 0) {
      try {
        isProcessing(true);
        hasError(false);
        final response = await HttpService.dioGetRequest(
          url: "${ApiConstants.baseUrl}order/order_list/",
          queryParameters: {"user_id": UserPreferences.userId},
        );

        if (response.statusCode == 200) {
          // List<dynamic> data = response.data['data'];
          // List<OrderList> orders =
          //     data.map((order) => OrderList.fromJson(order)).toList();
          final jsonData = orderListModelFromJson(jsonEncode(response.data));
          orderItemList.assignAll(jsonData.orderListData);
        }
      } catch (error) {
        hasError(true);
        DebugLogger.error(error.toString());
      } finally {
        isProcessing(false);
      }
    }
  }

  Future<void> refreshOrders() async {
    if (networkStateController.isInternetConnected.isTrue) {
      if (isProcessing.isFalse) {
        hasError(false);
        orderItemList.clear();
        await fetchTheOrderList();
      } else if (hasError.isTrue) {
        hasError(false);
        orderItemList.clear();
        await fetchTheOrderList();
      }
    } else {
      return;
    }
  }

  List<PaymentItem> createOrder() {
    int userId = UserPreferences.userId;
    var orderTotal = priceCalculationData.first.orderTotal.toString();
    var orderItems = cartItemList
        .map((item) => {
              "book_id": item.bookId,
              "book_type": "1", // Assuming the book type is always 1
              "quantity": 1, // Assuming the quantity is always 1
              "book_sub_total_amount": item.bookPrice.toString()
            })
        .toList();

    var paymentItems = {
      PaymentItem(
        label: 'Notespaedia',
        amount: orderTotal,
        status: PaymentItemStatus.final_price,
      )
    }.toList();
    return paymentItems;
  }

  Future<String?> createOrderAndFetchUrl() async {
    int userId = UserPreferences.userId;
    var orderTotal = priceCalculationData.first.orderTotal.toString();
    var subTotal = priceCalculationData.first.subTotalAmount.toString();
    var discount = priceCalculationData.first.discountAmount.toString();
    var tax = priceCalculationData.first.taxAmount.toString();
    var promoCodeController = Get.find<PromoCodeController>();
    //String? couponCode = promoCodeController.appliedCoupon.value.isNotEmpty ? promoCodeController.appliedCoupon.value : null;
    String? couponId = promoCodeController.appliedCouponId.value.isNotEmpty
        ? promoCodeController.appliedCouponId.value
        : null;

    var orderItems = cartItemList
        .map((item) => {
              "book_id": item.bookId,
              "book_type": "1", // Assuming the book type is always 1
              "quantity": 1, // Assuming the quantity is always 1
              "book_sub_total_amount": subTotal
            })
        .toList();
    fetchThePriceDetails();
    var data = {
      "user_id": userId,
      "payment_method_id": 1,
      "coupon_id": couponId,
      "sub_total_amount": subTotal,
      "discount_amount": discount,
      "tax_amount": tax,
      "total_amount": orderTotal,
      "address_id": 2, // Assuming a static value for address_id
      "order_items": orderItems
    };

    try {
      final response = await HttpService.dioPostRequest(
        url: "${ApiConstants.baseUrl}order/create_order/",
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Order created successfully: ${response.data}');
        return response.data['checkout_session_url'];
      } else {
        print(
            'Error creating order: ${response.statusCode} - ${response.data}');
        return null;
      }
    } catch (e) {
      print('Exception occurred while creating order: $e');
      return null;
    }
  }

  Future<String?> createOrderAndFetchUrforOrder(int selectedBookId) async {
    int userId = UserPreferences.userId;
    var subtotal = priceCalculationData.first.subTotalAmount.toString();
    var orderTotal = priceCalculationData.first.orderTotal.toString();
    var tax = priceCalculationData.first.taxAmount.toString();
    var orderItems = [
      {
        "book_id": selectedBookId,
        "book_type": "1", // Assuming the book type is always "1"
        "quantity": 1, // Assuming you're ordering a single quantity of the book
        "book_sub_total_amount":
            subtotal // Using the bookPrice passed to the function
      }
    ];
    fetchThePriceDetails();
    var data = {
      "user_id": userId,
      "payment_method_id": 1,
      "coupon_id": "0",
      "sub_total_amount": subtotal,
      "discount_amount": "0",
      "tax_amount": tax,
      "total_amount": orderTotal,
      "address_id": 2,
      "order_items": orderItems,
    };

    print("Sending data to create order: $data");

    try {
      final response = await HttpService.dioPostRequest(
        url: "${ApiConstants.baseUrl}order/create_order/",
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Order created successfully: ${response.data}');
        return response.data['checkout_session_url'];
      } else {
        print(
            'Error creating order: ${response.statusCode} - ${response.data}');
        return null;
      }
    } catch (e) {
      print('Exception occurred while creating order: $e');
      return null;
    }
  }

  Future<void> fetchTheDetailList({
    BuildContext? context,
    required int orderId,
  }) async {
    if (authController.isLoggedIn.isTrue && authController.isUserId > 0) {
      try {
        isProcessing(true);
        hasError(false);
        final response = await HttpService.dioGetRequest(
          url: "${ApiConstants.baseUrl}order/order_detail/",
          queryParameters: {"order_id": orderId},
        );

        if (response.statusCode == 200) {
          final jsonData = orderDetailModelFromJson(jsonEncode(response.data));
          orderDetailList.assign(jsonData.listData);
          //
        } else {
          DebugLogger.warning('${response.statusCode}');
          hasError(true);
        }
      } catch (error) {
        hasError(true);
        DebugLogger.error(error.toString());
      } finally {
        isProcessing(false);
      }
    }
  }
}
