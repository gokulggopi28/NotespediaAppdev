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

  @override
  void onInit() {
    super.onInit();

    fetchUserProfile(UserPreferences.userId);
  }
}
