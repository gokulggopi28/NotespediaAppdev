import 'package:dio/dio.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import 'package:notespedia/utils/constants/app_export.dart';

import '../../../../models/subscription_model.dart';
import '../../../../models/user_profile_model.dart';

Future<Plan> fetchPlans() async {
  var userProfileResponse = await fetchUserProfile();
  var courseId = userProfileResponse?.data.courseId ?? "";
  String os = DeviceHelper.isIOS() ? 'ios' : 'android';
  var response =
      await Dio().get('https://notespaedia.deienami.com/api/plan/plans_list/?course_id=$courseId&os=$os');
  var data = response.data['data'];
  return Plan.fromJson(data);
}

Future<UserData?> fetchUserProfile() async {
  try {
    int? fetchedUserId = UserPreferences.userId;
    if (fetchedUserId == null) {
      print('Error: User ID is null in UserPreferences');
      return null;
    }

    var response = await Dio().get(
        'http://notespaedia.deienami.com/api/users/profile/?user_id=$fetchedUserId');
    if (response.statusCode == 200) {
      var userData = UserData.fromJson(response.data);
      return userData;
     } else {
      print('Failed to fetch user profile: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching user profile: $e');
  }
}
