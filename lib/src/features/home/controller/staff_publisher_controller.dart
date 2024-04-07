import 'dart:convert';

import 'package:notespedia/models/book_list_by_staff_id.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class StaffPublisherController extends GetxController {
  //
  final networkStateController = Get.find<NetworkStateController>();

  final carouselController = CarouselController();
  final gridviewScrollController = ScrollController();
  var selectedCourseId = Rxn<int>();

  final currentSlider = 0.obs;

  final int _itemLimit = 6;
  int _currentPage = 1;

  final isProcessing = false.obs;
  final hasError = false.obs;
  final isMoreDataAvailable = true.obs;

  final selectedStaffPublisherIndex = 0.obs;
  final staffPublishersList = <StaffPublishersList>[].obs;
  final bookListByStaffId = <BookListByStaffId>[].obs;
  var staffBooksDetailList = <BookDetailData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchStaffPublisher();
    paginateGridview();
  }

  void onCarouselPageChange(int index) {
    currentSlider.value = index;
  }

  void onStaffPublisherSelection(int index) {
    selectedStaffPublisherIndex.value = index;
  }

  int findPositionByStaffId(int staffId) {
    for (int i = 0; i < staffPublishersList.length; i++) {
      if (staffPublishersList[i].staffId == staffId) {
        _currentPage = 1;
        fetchBookByStaffId(staffId);
        return i; // Return the index when staff ID is found
      }
    }
    return 0; // Return 0 if staff ID is not found
  }

  void updateForSelectedCourse(int courseId) {
    selectedCourseId.value = courseId;
    staffPublishersList.clear();
    fetchStaffPublisher(); // Fetch stories with the new filter
  }

  Future<void> fetchStaffPublisher() async {
    try {
      isProcessing(true);
      hasError(false);
      String url = "${ApiConstants.baseUrl}publishers/staff";

      // Check if a course ID is selected and append it to the URL
      if (selectedCourseId.value != null) {
        url += "/?course_id=${selectedCourseId.value}";
      }

      final response = await HttpService.dioGetRequest(url: url);

      if (response.statusCode == 200) {
        final jsonData =
            bookPublishersModelFromJson(json.encode(response.data));
        staffPublishersList.assignAll(jsonData.staffPublisher);
      } else {
        DebugLogger.warning('Response status code: ${response.statusCode}');
        hasError(true);
      }
    } catch (error) {
      DebugLogger.error('Error fetching staff publishers: $error');
      hasError(true);
    } finally {
      isProcessing(false);
    }
  }

  Future<void> fetchBookByStaffId(int staffId) async {
    try {
      isProcessing(true);
      hasError(false);
      isMoreDataAvailable(true);
      final response = await HttpService.dioGetRequest(
        url: "${ApiConstants.baseUrl}/books/books/?staff_id=[$staffId]",
      );

      if (response.statusCode == 200) {
        final jsonData =
            bookListByStaffIdModelFromJson(json.encode(response.data));
        if (jsonData.nextPage == null) isMoreDataAvailable(false);
        bookListByStaffId.assignAll(jsonData.results);
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
        staffBooksDetailList.any((detail) => detail.bookId == bookId);

    if (existingDetail == false) {
      try {
        final response = await HttpService.dioGetRequest(
            url: "${ApiConstants.baseUrl}books/books/$bookId");

        if (response.statusCode == 200) {
          final jsonData = bookDetailsModelFromJson(json.encode(response.data));
          staffBooksDetailList.add(jsonData.bookDetailData);
        } else {
          DebugLogger.warning(
              'Failed to fetch book details: ${response.statusCode}');
        }
      } catch (error) {
        DebugLogger.error("Exception: $error");
      }
    }
  }

  Future<void> refreshStaffPublishers() async {
    if (networkStateController.isInternetConnected.isFalse) {
      DebugLogger.warning("No Internet");
      return;
    }

    if (isProcessing.isFalse || hasError.isTrue) {
      _currentPage = 1;
      hasError(false);
      isMoreDataAvailable(true);
      staffPublishersList.clear();
      await fetchStaffPublisher();
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
          // await fetchBookByStaffId(findIndexByStaffId);
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
