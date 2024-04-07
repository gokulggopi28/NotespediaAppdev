import 'package:dio/dio.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants/api_constants.dart';

class SubScription {
  Dio dio = Dio();

  Future<dynamic> getUserSubscription() async {
    var userId = UserPreferences.userId;
    String url =
        "${ApiConstants.baseUrl}users/user_subscription/?user_id=$userId";

    try {
      Response response = await dio.get(url);
      return response.data;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
