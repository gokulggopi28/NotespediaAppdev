import 'dart:convert';

import 'package:notespedia/models/new_fresh_released_model.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class NewFreshReleaseController extends GetxController {
  final networkStateController = Get.find<NetworkStateController>();
  final bookDetailsController = Get.find<BooksDetailController>();

  final listviewScrollController = ScrollController();
  final gridviewScrollController = ScrollController();
  var selectedAuthorIds = <int>[].obs;
  var selectedCategoryIds = <int>[].obs;
  var selectedCourseId = Rxn<int>();

  final int _itemLimit = 6;
  int _currentPage = 1;
  //var selectedCategoryIds = <int>[].obs;

  var isProcessing = false.obs;
  var hasError = false.obs;
  var isMoreDataAvailable = true.obs;

  var newfreshReleaseBookList = <NewFreshReleaseBookList>[].obs;

  @override
  void onInit() {
    fetchFreshReleaseBooks();
    paginateListview();
    paginateGridview();
    super.onInit();
  }

  void applyCategoryFilter(List<int> categoryIds) async {
    selectedCategoryIds.assignAll(categoryIds);
    await refreshFreshReleaseBooks();
  }

  void updateForSelectedCourse(int courseId) {
    selectedCourseId.value = courseId;
    _currentPage = 1; // Reset to fetch new filtered data
    fetchFreshReleaseBooks(); // Fetch books with the new filter
  }

  Future<void> fetchFreshReleaseBooks() async {
    try {
      isProcessing(true);
      isMoreDataAvailable(true);
      hasError(false);

      Map<String, dynamic> queryParams = {
        "fresh_released": 1,
        "page_size": _itemLimit,
        "page": _currentPage,
      };
      if (selectedCourseId.value != null) {
        queryParams["course_id"] =
            "[${selectedCourseId.value}]"; // Ensure it's treated as a list
      }

      if (selectedAuthorIds.isNotEmpty) {
        queryParams["staff_id"] = "[" + selectedAuthorIds.join(',') + "]";
      }

      if (selectedCategoryIds.isNotEmpty) {
        queryParams["category_id"] = "[" + selectedCategoryIds.join(',') + "]";
      }

      final response = await HttpService.dioGetRequest(
        url: "${ApiConstants.baseUrl}books/books/",
        queryParameters: queryParams,
      );

      // Clear the existing book list before appending new data
      if (_currentPage == 1) {
        newfreshReleaseBookList.clear();
      }

      if (response.statusCode == 200) {
        var jsonData =
            newfreshReleaseBookModelFromJson(json.encode(response.data));

        isMoreDataAvailable(jsonData.nextPage != null);
        newfreshReleaseBookList.addAll(jsonData.newfreshRelease);
      } else {
        DebugLogger.warning('Response status code: ${response.statusCode}');
        hasError(true);
        isMoreDataAvailable(false);
      }
    } catch (error) {
      hasError(true);
      isMoreDataAvailable(false);
      DebugLogger.error('Error: $error');
    } finally {
      isProcessing(false);
    }
  }

  Future<void> fetchBooksBySelectedCategories(List<int> categoryIds) async {
    selectedCategoryIds.assignAll(categoryIds);
    await fetchFreshReleaseBooks(); // Modify this method to use category IDs
  }

  Future<void> refreshFreshReleaseBooks() async {
    if (networkStateController.isInternetConnected.isFalse) {
      DebugLogger.warning("No Internet");
      return;
    }

    if (isProcessing.isFalse || hasError.isTrue) {
      _currentPage = 1;
      hasError(false);
      isMoreDataAvailable(true);
      newfreshReleaseBookList.clear();
      bookDetailsController.bookDetailData.clear();
      await fetchFreshReleaseBooks();
    }
  }

  void paginateListview() {
    listviewScrollController.addListener(() async {
      if (isProcessing.isTrue || !isMoreDataAvailable.isTrue) {
        return;
      }

      if (listviewScrollController.position.pixels ==
          listviewScrollController.position.maxScrollExtent) {
        if (networkStateController.isInternetConnected.isTrue) {
          _currentPage++;
          await fetchFreshReleaseBooks();
        }
      }
    });
  }

  void paginateGridview() {
    gridviewScrollController.addListener(() async {
      if (isProcessing.isTrue || !isMoreDataAvailable.isTrue) {
        return;
      }

      if (gridviewScrollController.position.pixels ==
          gridviewScrollController.position.maxScrollExtent) {
        if (networkStateController.isInternetConnected.isTrue) {
          _currentPage++;
          await fetchFreshReleaseBooks();
        }
      }
    });
  }

  @override
  void dispose() {
    listviewScrollController.dispose();
    gridviewScrollController.dispose();
    super.dispose();
  }
}
