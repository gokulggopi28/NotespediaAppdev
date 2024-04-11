import 'package:get/get.dart';

import '../../../models/user_profile.dart';
import '../../../repositories/user_preferences.dart';
import '../../../utils/constants/app_export.dart';
import 'user_profile_repo.dart';

class UserProfileController extends GetxController {
  final UserProfileRepository repository = UserProfileRepository();
  final Rx<UserProfile?> userProfile = Rx<UserProfile?>(null);

  void fetchUserProfile(int userId) async {
    try {
      final data = await repository.fetchUserProfile(userId);
      userProfile.value = data;
      if (data != null) {
        Get.find<CourseSelectionController>()
            .setSelectedCourseByName(data.courseName);
      }
    } catch (e) {
      // Handle errors here
    }
  }

  RxString subscriptionStatus = "Get Notified".obs;
  RxInt number = 0.obs;

  void checkSubscription(int count) {
    if (count == 0) {
      number.value = 0;
      subscriptionStatus.value = "Get Notified";
    } else if (count == 1) {
      number.value = 1;
      subscriptionStatus.value = "Subscribed";
    }
  }

  // void getNotified() {
  //   // Your logic to handle subscription when count is "0"
  //   // For example:
  //   // Call your API or perform any action here
  //   subscriptionStatus.value = "Subscribed";
  // }

  void clearUserProfile() {
    userProfile.value = null;
  }

  @override
  void onInit() {
    super.onInit();

    fetchUserProfile(UserPreferences.userId);
  }
}
