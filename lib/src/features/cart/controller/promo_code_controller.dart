import 'package:dio/dio.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class PromoCodeController extends GetxController {
  var isLoading = false.obs;
  var promoCodes = <dynamic>[].obs;
  var fetchError = ''.obs;
  var appliedCoupon = ''.obs;
  var appliedCouponId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPromoCodes();
  }

  void applyCoupon(String couponCode, int couponId) {
    appliedCoupon.value = couponCode;
    appliedCouponId.value = couponId.toString();
    // Add any other logic you might need when applying a coupon
  }

  void clearCoupon() {
    appliedCoupon.value = '';
    appliedCouponId.value = '';
    // Optionally, trigger any updates needed after clearing the coupon
  }

  void fetchPromoCodes() async {
    try {
      isLoading(true);
      var response =
          await Dio().get('http://139.59.38.234/api/loyalty/offers/');
      promoCodes.assignAll(response.data['data']);
    } catch (e) {
      fetchError(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
