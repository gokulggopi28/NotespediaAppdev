import 'dart:convert';

import 'package:notespedia/models/books_search_model.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class SearchScreenController extends GetxController {
  //
  final networkStateController = Get.find<NetworkStateController>();
  final searchTextController = TextEditingController();

  var isProcessing = false.obs;
  var hasError = false.obs;

  var searchTopCategoriesList = <SearchTopCategoriesList>[].obs;
  var searchTopPublishersList = <SearchTopPublishersList>[].obs;
  var searchBooksList = <SearchBooksList>[].obs;
  var searchbookDetailList = <BookDetailData>[].obs;

  @override
  void onInit() {
    //fetchFirstSearchData();
    super.onInit();
  }

  void clearSearchData() {
    searchTopCategoriesList.clear();
    searchTopPublishersList.clear();
    searchBooksList.clear();
    // Optionally clear the search text as well
    searchTextController.clear();
  }

  Future<void> fetchFirstSearchData() async {
    try {
      isProcessing(true);
      hasError(false);

      final response = await HttpService.dioGetRequest(
        url: "${ApiConstants.baseUrl}books/search/",
        queryParameters: {"search_text": null},
      );

      if (response.statusCode == 200) {
        var jsonData = bookSearchModelFromJson(json.encode(response.data));

        searchTopCategoriesList
            .assignAll(jsonData.searchData.searchTopCategoriesList);
        searchTopPublishersList
            .assignAll(jsonData.searchData.searchTopPublishersList);
        searchBooksList.assignAll(jsonData.searchData.searchBooksList);
      } else {
        DebugLogger.warning('${response.statusCode}');
        hasError(true);
      }
    } catch (error) {
      hasError(true);
      DebugLogger.error(error.toString());
    } finally {
      isProcessing(false);
    }
  }

  Future<void> fetchSearchResult({required String searchText}) async {
    try {
      isProcessing(true);
      hasError(false);
      final response = await HttpService.dioGetRequest(
        url: "${ApiConstants.baseUrl}books/search/",
        queryParameters: {"search_text": searchText},
      );

      if (response.statusCode == 200) {
        var jsonData = bookSearchModelFromJson(json.encode(response.data));

        searchTopCategoriesList
            .assignAll(jsonData.searchData.searchTopCategoriesList);
        searchTopPublishersList
            .assignAll(jsonData.searchData.searchTopPublishersList);
        searchBooksList.assignAll(jsonData.searchData.searchBooksList);
      } else {
        DebugLogger.warning('${response.statusCode}');
        hasError(true);
      }
    } catch (error) {
      hasError(true);
      DebugLogger.error(error.toString());
    } finally {
      isProcessing(false);
    }
  }

  Future<void> fetchBookDetails(int bookId) async {
    var existingDetail =
        searchbookDetailList.any((detail) => detail.bookId == bookId);

    if (existingDetail == false) {
      try {
        final response = await HttpService.dioGetRequest(
            url: "${ApiConstants.baseUrl}books/books/$bookId");

        if (response.statusCode == 200) {
          final jsonData = bookDetailsModelFromJson(json.encode(response.data));
          searchbookDetailList.add(jsonData.bookDetailData);
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
