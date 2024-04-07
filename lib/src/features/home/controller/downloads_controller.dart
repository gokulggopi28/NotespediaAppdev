import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:notespedia/repositories/user_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/book_grid_view_model.dart';
import '../../../../models/downloads_model.dart';
import '../../../../models/local/local_save_for_later_model.dart';
import '../../../../utils/constants/app_export.dart';

class DownloadsController extends GetxController {
  var isProcessing = false.obs;
  var hasError = false.obs;

  var downloadedBooksList = <DownloadData>[].obs;
  var downloadedbookDetailList = <BookDetailData>[].obs;
  var downloadedbookChapterDetailList = <Chapter>[].obs;

  var bookChapterGridViewModel = Rxn<BookChapterGridViewModel>();
  @override
  void onInit() {
    super.onInit();
    // loadDownloadsFromPrefs();
    fetchDownloads();
  }

  Future<void> fetchDownloads() async {
    isProcessing(true);
    hasError(false);

    final userId = UserPreferences.userId; // Default to 0 if not set

    try {
      final response = await dio.Dio().get(
          'https://notespaedia.deienami.com/api/shelf/downloads/?user_id=$userId');
      print('API Response: ${response.data}');
      if (response.statusCode == 200) {
        List jsonResponse = response.data['data'];
        var books = jsonResponse
            .map<DownloadData>((data) => DownloadData.fromJson(data))
            .toList();
        downloadedBooksList.assignAll(books);
        // saveDownloadsToPrefs();
      } else {
        print('Failed to load books: ${response.statusCode}');
        print('Response data: ${response.data}');
        hasError.value = true;
      }
    } catch (e) {
      DebugLogger.error('Failed to load books due to network issue: $e');
      if (e is dio.DioError) {
        DebugLogger.error("DioError: ${e.response?.statusCode} - ${e.message}");
      }
      hasError(true);
    } finally {
      isProcessing(false);
    }
  }

  Future<void> updateBookDownloadView(File file, Chapter chapter) async {
    Dio dioInstance = Dio();
    try {
      var formData = dio.FormData.fromMap({
        'user_id': UserPreferences.userId.toString(),
        'book_id': chapter.bookId.toString(),
        'chapter_id': chapter.id.toString(),
        'file': await dio.MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last),
      });

      print("Data being sent to the API:");
      print("User ID: ${UserPreferences.userId.toString()}");
      print("Book ID: ${chapter.bookId.toString()}");
      print("Chapter ID: ${chapter.id.toString()}");
      print("File: ${file.path.split('/').last}");
      final response = await dioInstance.put(
        'https://notespaedia.deienami.com/api/shelf/update_book_download_view/',
        data: formData,
      );

      // Logging the response
      print("Update book download view response: ${response.data}");
    } catch (e) {
      print('Error updating book download view: $e');
    }
  }

  Future<void> fetchBookChaptersGridView(int bookId) async {
    final userId = UserPreferences.userId;

    try {
      final response = await dio.Dio().get(
        'https://notespaedia.deienami.com/api/shelf/book_chapters_grid_view/',
        queryParameters: {
          'user_id': userId,
          'book_id': bookId,
        },
      );

      if (response.statusCode == 200) {
        bookChapterGridViewModel.value =
            BookChapterGridViewModel.fromJson(response.data);
      } else {
        DebugLogger.warning(
            'Failed to fetch book chapters grid view: ${response.statusCode}');
      }
    } catch (error) {
      DebugLogger.error("Exception: $error");
    }
  }

  Future<void> sendChapterUpdateConfirmation(
      int bookId, int chapterId, int confirmation) async {
    final userId = UserPreferences.userId;

    try {
      var formData = dio.FormData.fromMap({
        'user_id': userId.toString(),
        'book_id': bookId.toString(),
        'chapter_id': chapterId.toString(),
        'confirmation': confirmation.toString(),
      });
      print("Sending to API: ");
      print("User ID: $userId");
      print("Book ID: $bookId");
      print("chapter ID: $chapterId");
      print("Confirmation: $confirmation");
      final response = await dio.Dio().post(
        'https://notespaedia.deienami.com/api/shelf/chapter_update_confirmation/',
        data: formData,
      );
      print("API Response: ");
      print(response.data);
      if (response.statusCode == 200) {
        DebugLogger.info("Chapter update confirmation successful.");
      } else {
        DebugLogger.warning("Failed to send chapter update confirmation.");
      }
    } catch (e) {
      DebugLogger.error("Error sending chapter update confirmation: $e");
    }
  }

  Future<void> deleteChapter(
      int bookId, int chapterId, BuildContext context) async {
    final userId = UserPreferences.userId;

    try {
      var formData = dio.FormData.fromMap({
        'user_id': userId.toString(),
        'book_id': bookId.toString(),
        'chapter_id': chapterId.toString(),
      });
      print("Sending to API: ");
      print("User ID: $userId");
      print("Book ID: $bookId");
      print("chapter ID: $chapterId");
      //print("Confirmation: $confirmation");
      final response = await dio.Dio().delete(
        'https://notespaedia.deienami.com/api/shelf/delete_book_edited_download_view/',
        data: formData,
      );
      print("API Response: ");
      print(response.data);
      if (response.statusCode == 200) {
        DebugLogger.info("Chapter delete successful.");
        HelperFunctions.showTopSnackBar(
          context: context,
          title: "Success",
          message: "Cart item updated successfully",
        );
      } else {
        DebugLogger.warning("Failed to send chapter update confirmation.");
      }
    } catch (e) {
      DebugLogger.error("Error sending chapter update confirmation: $e");
    }
  }

  Future<void> fetchBookDetails(int bookId) async {
    var existingDetail =
        downloadedbookDetailList.any((detail) => detail.bookId == bookId);

    if (existingDetail == false) {
      try {
        final response = await HttpService.dioGetRequest(
            url: "${ApiConstants.baseUrl}books/books/$bookId");

        if (response.statusCode == 200) {
          final jsonData = bookDetailsModelFromJson(json.encode(response.data));
          downloadedbookDetailList.add(jsonData.bookDetailData);
        } else {
          DebugLogger.warning(
              'Failed to fetch book details: ${response.statusCode}');
        }
      } catch (error) {
        DebugLogger.error("Exception: $error");
      }
    }
  }
}
