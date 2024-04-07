import 'dart:convert';

import 'package:notespedia/utils/constants/app_export.dart';

class TopReadsController extends GetxController {
  //
  final networkStateController = Get.find<NetworkStateController>();
  var selectedCourseId = Rxn<int>();
  final int _itemLimit = 6;
  int _currentPage = 1;

  var isProcessing = false.obs;
  var hasError = false.obs;
  var isMoreDataAvailable = true.obs;

  final listviewScrollController = ScrollController();

  var topReadBookList = <TopReadBookList>[].obs;
  var topReadBooksDetailList = <BookDetailData>[].obs;

  @override
  void onInit() {
    fetchTopReadBooks(_currentPage);
    paginateListview();
    super.onInit();
  }

  @override
  void dispose() {
    listviewScrollController.dispose();
    super.dispose();
  }

  Future<void> fetchTopReadBooks(int page) async {
    if (networkStateController.isInternetConnected.isTrue) {
      try {
        isProcessing(true);
        hasError(false);
        isMoreDataAvailable(true);
        String url =
            "${ApiConstants.baseUrl}books/books/?top_reads=1&page_size=$_itemLimit&page=$_currentPage";

        if (selectedCourseId.value != null) {
          // Format course_id as a list
          url += "&course_id=[${selectedCourseId.value}]";
        }
        final response = await HttpService.dioGetRequest(url: url);

        if (response.statusCode == 200) {
          var jsonData = topReadBooksModelFromJson(json.encode(response.data));
          if (jsonData.nextPage == null) {
            isMoreDataAvailable(false);
          }
          if (jsonData.topRead.isNotEmpty) {
            topReadBookList.addAll(jsonData.topRead);
          }
        } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
          DebugLogger.warning('Client Side error: ${response.statusCode}');
          hasError(true);
          isMoreDataAvailable(false);
        } else if (response.statusCode! >= 500 && response.statusCode! < 600) {
          DebugLogger.warning('Server Side error: ${response.statusCode}');
          hasError(true);
          isMoreDataAvailable(false);
        } else {
          DebugLogger.warning('${response.statusCode}');
          hasError(true);
          isMoreDataAvailable(false);
        }
      } catch (error) {
        hasError(true);
        isMoreDataAvailable(false);
        DebugLogger.error(error.toString());
      } finally {
        isProcessing(false);
      }
    } else {
      isMoreDataAvailable(false);
      hasError(true);
      DebugLogger.warning("No Internet");
    }
  }

  void paginateListview() {
    listviewScrollController.addListener(() async {
      if (isProcessing.isTrue) {
        return;
      } else if (listviewScrollController.position.pixels ==
          listviewScrollController.position.maxScrollExtent) {
        if (isMoreDataAvailable.isTrue && isProcessing.isFalse) {
          if (networkStateController.isInternetConnected.isTrue) {
            DebugLogger.info(
                "Top Read Page: $_currentPage \nTop Read Index Length: ${topReadBookList.length}");
            _currentPage++;
            await fetchTopReadBooks(_currentPage);
          }
        } else {
          return;
        }
      }
    });
  }

  Future<void> fetchBookDetails(int bookId) async {
    var existingDetail =
        topReadBooksDetailList.any((detail) => detail.bookId == bookId);

    if (existingDetail == false) {
      try {
        final response = await HttpService.dioGetRequest(
            url: "${ApiConstants.baseUrl}books/books/$bookId");

        if (response.statusCode == 200) {
          final jsonData = bookDetailsModelFromJson(json.encode(response.data));
          topReadBooksDetailList.add(jsonData.bookDetailData);
        } else {
          DebugLogger.warning(
              'Failed to fetch book details: ${response.statusCode}');
        }
      } catch (error) {
        DebugLogger.error("Exception: $error");
      }
    }
  }

  Future<void> refreshTopReadBooks() async {
    if (networkStateController.isInternetConnected.isTrue) {
      if (isProcessing.isFalse) {
        _currentPage = 1;
        hasError(false);
        isMoreDataAvailable(true);
        topReadBookList.clear();
        topReadBooksDetailList.clear();
        await fetchTopReadBooks(_currentPage);
      } else if (hasError.isTrue) {
        _currentPage = 1;
        hasError(false);
        isMoreDataAvailable(true);
        topReadBookList.clear();
        topReadBooksDetailList.clear();
        await fetchTopReadBooks(_currentPage);
      }
    } else {
      return;
    }
  }
}
