import 'package:get/get.dart';
import 'package:notespedia/src/features/subscription/subscription_repo.dart';

class SubscriptionController extends GetxController {
  var subscriptionStatus = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserSubscription();
  }

  void fetchUserSubscription() async {
    isLoading(true);
    var response = await SubScription().getUserSubscription();
    if (response != null && response['subscription_status'] != null) {
      subscriptionStatus(response['subscription_status']);
    } else {
      subscriptionStatus('error'); // Handle error or no data scenario
    }
    isLoading(false);
  }
}
