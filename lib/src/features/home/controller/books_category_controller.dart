import 'dart:convert';

import 'package:notespedia/models/book_list_by_category_id.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class BooksCategoryController extends GetxController {
  //
  final networkStateController = Get.find<NetworkStateController>();
  final gridviewScrollController = ScrollController();

  final int _itemLimit = 6;
  int _currentPage = 1;
  var selectedCourseId = Rxn<int>();
  final isProcessing = false.obs;
  final hasError = false.obs;
  final isMoreDataAvailable = true.obs;

  final selectedBookCategoryIndex = 0.obs;
  final booksCategoryList = <BookCategoryModel>[].obs;
  final bookListByCategoryId = <BookListByCategoryId>[].obs;
  var categorybasedBooksDetailList = <BookDetailData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryBooks();
  }

  void onCategorySelection(int categoryId) {
    final index = booksCategoryList
        .indexWhere((category) => category.categoryId == categoryId);
    if (index != -1) {
      selectedBookCategoryIndex.value = index;
    }
  }

  int findPositionByCategoryId(int categoryId) {
    for (int i = 0; i < booksCategoryList.length; i++) {
      if (booksCategoryList[i].categoryId == categoryId) {
        _currentPage = 1;
        fetchCategoryBooksByStaffId(categoryId);
        return i; // Return the index when staff ID is found
      }
    }
    return 0; // Return 0 if staff ID is not found
  }

  Future<void> fetchCategoryBooks() async {
    try {
      isProcessing(true);

      String url = "${ApiConstants.baseUrl}books/categories";
      if (selectedCourseId.value != null) {
        url += "/?course_id=${selectedCourseId.value}";
      }

      final response = await HttpService.dioGetRequest(url: url);

      if (response.statusCode == 200) {
        final jsonData =
            bookCategoriesModelFromJson(json.encode(response.data));
        booksCategoryList.addAll(jsonData);
      }
    } catch (error) {
      hasError(true);
      DebugLogger.error(error.toString());
    } finally {
      isProcessing(false);
    }
  }

  Future<void> fetchCategoryBooksByStaffId(int categoryId) async {
    try {
      isProcessing(true);
      hasError(false);
      isMoreDataAvailable(true);
      final response = await HttpService.dioGetRequest(
        url: "${ApiConstants.baseUrl}/books/books/?category_id=[$categoryId]",
      );

      if (response.statusCode == 200) {
        final jsonData =
            categoryBasedBookModelFromJson(json.encode(response.data));
        if (jsonData.nextPage == null) isMoreDataAvailable(false);
        bookListByCategoryId.assignAll(jsonData.results);
      }
    } catch (error) {
      hasError(true);
      isMoreDataAvailable(false);
      DebugLogger.error(error.toString());
    } finally {
      isProcessing(false);
    }
  }

  Future<void> fetchBookDetails(int bookId) async {
    var existingDetail =
        categorybasedBooksDetailList.any((detail) => detail.bookId == bookId);

    if (existingDetail == false) {
      try {
        final response = await HttpService.dioGetRequest(
            url: "${ApiConstants.baseUrl}books/books/$bookId");

        if (response.statusCode == 200) {
          final jsonData = bookDetailsModelFromJson(json.encode(response.data));
          categorybasedBooksDetailList.add(jsonData.bookDetailData);
        } else {
          DebugLogger.warning(
              'Failed to fetch book details: ${response.statusCode}');
        }
      } catch (error) {
        DebugLogger.error("Exception: $error");
      }
    }
  }

  Future<void> refreshBooksCategory() async {
    if (networkStateController.isInternetConnected.isFalse) {
      DebugLogger.warning("No Internet");
      return;
    }

    if (isProcessing.isFalse || hasError.isTrue) {
      _currentPage = 1;
      hasError(false);
      isMoreDataAvailable(true);
      booksCategoryList.clear();
      await fetchCategoryBooks();
    }
  }

  void paginateGridview() {
    gridviewScrollController.addListener(() async {
      if (isProcessing.isTrue || !isMoreDataAvailable.isTrue) {
        return;
      }

      if (gridviewScrollController.position.pixels ==
          gridviewScrollController.position.maxScrollExtent) {
        if (networkStateController.isInternetConnected.isTrue) {
          // _currentPage++;
          // await fetchCategoryBooksByStaffId(findIndexByStaffId);
        }
      }
    });
  }

  @override
  void dispose() {
    gridviewScrollController.dispose();
    super.dispose();
  }
}
