import 'dart:convert';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import '../../../../models/local/local_save_for_later_model.dart';
import '../../../../utils/constants/app_export.dart'; // Update this import path according to your project structure.

class SaveForLaterBooksController extends GetxController {
  var isProcessing = false.obs;
  var hasError = false.obs;

  var saveForLaterBooksList = <SaveForLaterBook>[].obs;
  var saveforlaterbookDetailList = <BookDetailData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSaveForLaterBooks();
  }

  Future<void> fetchSaveForLaterBooks() async {
    // isProcessing(true);
    hasError(false);

    final userId = UserPreferences.userId; // Default to 0 if not set

    try {
      final response = await Dio().get(
          'http://139.59.38.234/api/shelf/save_for_later/?user_id=$userId');

      if (response.statusCode == 200) {
        List jsonResponse = response.data['data'];
        var books = jsonResponse
            .map<SaveForLaterBook>((data) => SaveForLaterBook.fromJson(data))
            .toList();
        saveForLaterBooksList.assignAll(books);
      } else {
        print('Failed to load books: ${response.statusCode}');
        print('Response data: ${response.data}');
        hasError.value = true;
      }
    } catch (e) {
      DebugLogger.error('Failed to load books due to network issue: $e');
      if (e is DioError) {
        // Handle DioError specifically if needed, e.g., by error code
        DebugLogger.error("DioError: ${e.response?.statusCode} - ${e.message}");
      }
      hasError(true);
    } finally {
      isProcessing(false);
    }
  }

  bool isBookSavedForLater(int bookId, int userId) {
    // Assuming that SaveForLaterBook has a 'bookId' and 'userId' field
    return saveForLaterBooksList
        .any((book) => book.bookId == bookId && book.userId == userId);
  }

  Future<void> fetchBookDetails(int bookId) async {
    var existingDetail =
        saveforlaterbookDetailList.any((detail) => detail.bookId == bookId);

    if (existingDetail == false) {
      try {
        final response = await HttpService.dioGetRequest(
            url: "${ApiConstants.baseUrl}books/books/$bookId");

        if (response.statusCode == 200) {
          final jsonData = bookDetailsModelFromJson(json.encode(response.data));
          saveforlaterbookDetailList.add(jsonData.bookDetailData);
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
