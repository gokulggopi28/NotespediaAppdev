import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import 'package:notespedia/utils/constants/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/books_review_model.dart';

class BooksDetailController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  var saveForLaterBooksList = <SaveForLaterBook>[].obs;
  var saveforlaterbookDetailList = <BookDetailData>[].obs;

  //
  final networkStateController = Get.find<NetworkStateController>();
  final authController = Get.find<AuthenticationController>();

  final int _itemLimit = 6;
  final int _currentPage = 1;

  var onTapProcessing = false.obs;

  var isProcessing = false.obs;
  var hasError = false.obs;
  var isMoreDataAvailable = true.obs;

  // var mergedBooks = <MergedBook>[].obs;

  var bookDetailData = <BookDetailData>[].obs;

  var bookChaptersList = <BookChaptersList>[].obs;
  var bookSuggestionList = <BookSuggestionList>[].obs;
  var authorRelatedBookList = <BookSuggestionList>[].obs;
  var bookReviewList = <ReviewData>[].obs;

  Future<void> onTapBookAction({
    required BuildContext ctx,
    required int selectedBookId,
  }) async {
    if (networkStateController.isInternetConnected.isTrue) {
      onTapProcessing(true);
      await fetchBookDetails(selectedBookId);
      await fetchChapterDetails(selectedBookId);
      await fetchSuggestedBooks(selectedBookId);
      await fetchAuthorRelatedBooks(selectedBookId);
      await fetchBookReviewDetails(selectedBookId);

      var bookById = bookDetailData
          .firstWhere((detail) => detail.bookId == selectedBookId);
      onTapProcessing(false);
      Get.to(() => BooksDetailsScreen(bookDetailData: bookById));
    } else {
      HelperFunctions.showSnackBar(
        context: ctx,
        message: "No Internet Connection..",
      );
    }
  }

  Future<void> saveBookForLater(int bookId, int userId) async {
    try {
      var response = await Dio().post(
        '${ApiConstants.baseUrl}/shelf/save_for_later/',
        data: {
          'book_id': bookId,
          'user_id': userId,
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Book saved for later successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to save the book for later',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while saving the book for later',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> removeBookFromSavedForLater(int savedBookId) async {
    try {
      var response = await Dio().delete(
        '${ApiConstants.baseUrl}/shelf/save_for_later/$savedBookId/',
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Book removed from saved for later successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to remove book from saved for later',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while removing the book from saved for later',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> fetchBookDetails(int bookId) async {
    try {
      final response = await HttpService.dioGetRequest(
        url: "${ApiConstants.baseUrl}books/books/$bookId",
      );

      if (response.statusCode == 200) {
        final jsonData = bookDetailsModelFromJson(json.encode(response.data));
        bookDetailData.assign(jsonData.bookDetailData);
      } else {
        DebugLogger.warning(
            'Failed to fetch book details: ${response.statusCode}');
      }
    } catch (error) {
      DebugLogger.error("Exception: $error");
    }
  }

  Future<void> fetchBookSuggestedDetails(int bookId) async {
    try {
      final response = await HttpService.dioGetRequest(
        url: "${ApiConstants.baseUrl}books/books/$bookId",
      );

      if (response.statusCode == 200) {
        final jsonData = bookDetailsModelFromJson(json.encode(response.data));
        bookDetailData.clear();
        bookDetailData.add(jsonData.bookDetailData);
        update();
      } else {
        DebugLogger.warning(
            'Failed to fetch book details: ${response.statusCode}');
      }
    } catch (error) {
      DebugLogger.error("Exception: $error");
    }
  }

  Future<void> fetchBookAuthorSuggestedDetails(int bookId) async {
    try {
      final response = await HttpService.dioGetRequest(
        url: "${ApiConstants.baseUrl}books/books/$bookId",
      );

      if (response.statusCode == 200) {
        final jsonData = bookDetailsModelFromJson(json.encode(response.data));
        bookDetailData.clear();
        bookDetailData.add(jsonData.bookDetailData);
        update();
      } else {
        DebugLogger.warning(
            'Failed to fetch book details: ${response.statusCode}');
      }
    } catch (error) {
      DebugLogger.error("Exception: $error");
    }
  }

  Future<void> fetchChapterDetails(int bookId) async {
    try {
      final response = await HttpService.dioGetRequest(
        url: "${ApiConstants.baseUrl}books/book_chapters/",
        queryParameters: {"book_id": bookId, "user_id": UserPreferences.userId},
      );

      if (response.statusCode == 200) {
        final jsonData = bookChaptersModelFromJson(json.encode(response.data));
        bookChaptersList.assignAll(jsonData.chaptersData);
      } else {
        DebugLogger.warning(
            'Failed to fetch book details: ${response.statusCode}');
      }
    } catch (error) {
      DebugLogger.error("Exception: $error");
    }
  }

  Future<void> fetchSuggestedBooks(int bookId) async {
    if (authController.isLoggedIn.isTrue) {
      try {
        final response = await HttpService.dioGetRequest(
          url: "${ApiConstants.baseUrl}books/books_you_like/",
          queryParameters: {
            "user_id": UserPreferences.userId,
            "book_id": bookId,
          },
        );

        if (response.statusCode == 200) {
          final jsonData =
              bookSuggestionRelatedToBookIdFromJson(json.encode(response.data));
          bookSuggestionList.assignAll(jsonData.suggestionData);
        } else {
          DebugLogger.warning(
              'Failed to fetch book details: ${response.statusCode}');
        }
      } catch (error) {
        DebugLogger.error("Exception: $error");
      }
    }
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

  Future<void> fetchAuthorRelatedBooks(int bookId) async {
    try {
      final response = await HttpService.dioGetRequest(
        url: "${ApiConstants.baseUrl}books/read_more_author/",
        queryParameters: {"book_id": bookId},
      );

      if (response.statusCode == 200) {
        final jsonData =
            bookSuggestionRelatedToBookIdFromJson(json.encode(response.data));
        authorRelatedBookList.assignAll(jsonData.suggestionData);
      } else {
        DebugLogger.warning(
            'Failed to fetch book details: ${response.statusCode}');
      }
    } catch (error) {
      DebugLogger.error("Exception: $error");
    }
  }

  Future<void> fetchBookReviewDetails(int bookId) async {
    try {
      final response = await HttpService.dioGetRequest(
        url: "${ApiConstants.baseUrl}books/review/",
        queryParameters: {"book_id": bookId},
      );

      if (response.statusCode == 200) {
        final jsonData = reviewResponseFromJson(json.encode(response.data));
        bookReviewList.assignAll(jsonData.data);
      } else {
        DebugLogger.warning(
            'Failed to fetch book details: ${response.statusCode}');
      }
    } catch (error) {
      DebugLogger.error("Exception: $error");
    }
  }

  Future<void> deleteReview(int reviewId) async {
    // Log the URL being called to ensure it's correct
    final url = '${ApiConstants.baseUrl}books/review/$reviewId/';
    print('Attempting to delete review with URL: $url');

    try {
      var response = await Dio().delete(url);

      // Log the status code and response body for debugging
      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Review deleted successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Optionally, refresh the list of reviews here:
        // await fetchBookReviewDetails(someBookId);
      } else {
        Get.snackbar(
          'Error',
          'Failed to delete the review',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Log the exception
      print('Exception occurred while deleting review: $e');
      Get.snackbar(
        'Error',
        'An error occurred while deleting the review: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

// class MergedBook {
//   final int bookId;
//   final BookDetailData bookDetail;
//   final List<BookChaptersList> bookChaptersList;
//   final List<BookSuggestionList> bookSuggestionList;
//   final List<BookSuggestionList> authorRelatedBookList;

//   MergedBook({
//     required this.bookId,
//     required this.bookDetail,
//     required this.bookChaptersList,
//     required this.bookSuggestionList,
//     required this.authorRelatedBookList,
//   });
// }

// List<MergedBook> mergeBookLists(
//   List<BookDetailData> bookDetailList,
//   List<BookChaptersList> bookChaptersList,
//   List<BookSuggestionList> bookSuggestionList,
//   List<BookSuggestionList> authorRelatedBookList,
// ) {
//   Map<int, MergedBook> mergedBooks = {};

//   for (var bookDetail in bookDetailList) {
//     mergedBooks[bookDetail.bookId] = MergedBook(
//       bookId: bookDetail.bookId,
//       bookDetail: bookDetail,
//       bookChaptersList: [],
//       bookSuggestionList: [],
//       authorRelatedBookList: [],
//     );
//   }

//   for (var chapter in bookChaptersList) {
//     if (mergedBooks.containsKey(chapter.bookId)) {
//       mergedBooks[chapter.bookId]!.bookChaptersList.add(chapter);
//     }
//   }

//   for (var suggestion in bookSuggestionList) {
//     if (mergedBooks.containsKey(suggestion.bookId)) {
//       mergedBooks[suggestion.bookId]!.bookSuggestionList.add(suggestion);
//     }
//   }

//   for (var authorSuggestion in authorRelatedBookList) {
//     if (mergedBooks.containsKey(authorSuggestion.bookId)) {
//       mergedBooks[authorSuggestion.bookId]!
//           .bookSuggestionList
//           .add(authorSuggestion);
//     }
//   }

//   return mergedBooks.values.toList();
// }
