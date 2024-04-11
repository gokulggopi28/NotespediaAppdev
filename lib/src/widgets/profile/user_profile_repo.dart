import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../../../models/user_profile.dart';
import '../../../utils/constants/api_constants.dart';

class UserProfileRepository {
  final Dio _dio = Dio();

  Future<UserProfile> fetchUserProfile(int userId) async {
    try {
      final response = await _dio.get(
          'https://notespaedia.deienami.com/api/users/profile/?user_id=$userId');
      return UserProfile.fromJson(response.data);
    } on DioError catch (e) {
      // Handle DioError here
      throw Exception('Failed to load user profile');
    }
  }

  Future<void> getNotifiedApi(int userid, int val) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}users/get_me_notified/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{"user_id": userid, "get_me_notified": val}),
      );
      // Check if the response was successful (status code 200)
      if (response.statusCode == 200) {
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
