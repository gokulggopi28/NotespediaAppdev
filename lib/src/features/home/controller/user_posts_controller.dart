import 'dart:convert';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import '../../../../models/local/local_save_for_later_model.dart';

import '../../../../models/local_user_posts.dart';
import '../../../../utils/constants/app_export.dart';

class UserPostController extends GetxController {
  var isProcessing = false.obs;
  var hasError = false.obs;

  var userpostsList = <Post>[].obs;
  //var saveforlaterbookDetailList = <BookDetailData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserPosts();
  }

  Future<void> fetchUserPosts() async {
    // isProcessing(true);
    hasError(false);

    final userId = UserPreferences.userId;

    try {
      final response = await Dio().get(
          'https://notespaedia.deienami.com/api/shelf/book_upload/?user_id=$userId');

      if (response.statusCode == 200) {
        // Directly parsing the response data as a list of posts
        List jsonResponse = response.data;
        var posts =
            jsonResponse.map<Post>((data) => Post.fromJson(data)).toList();
        userpostsList.assignAll(posts);
      } else {
        print('Failed to load posts: ${response.statusCode}');
        print('Response data: ${response.data}');
        hasError.value = true;
      }
    } catch (e) {
      print('Failed to load posts due to network issue: $e');
      if (e is DioError) {
        print("DioError: ${e.response?.statusCode} - ${e.message}");
      }
      hasError(true);
    } finally {
      isProcessing(false);
    }
  }
}
