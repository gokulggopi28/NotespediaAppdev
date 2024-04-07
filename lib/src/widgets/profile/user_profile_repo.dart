import 'package:dio/dio.dart';
import '../../../models/user_profile.dart';

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
}
