import 'dart:convert';

import 'package:notespedia/utils/constants/app_export.dart';

class CircularStoryController extends GetxController {
  //
  final networkStateController = Get.find<NetworkStateController>();

  var isProcessing = false.obs;
  var hasError = false.obs;

  var circularStoryList = <CircularStoryList>[].obs;
  var visitedStoryIndices = [].obs;
  var selectedCourseId = Rxn<int>();

  @override
  void onInit() {
    initializeVisitedStoryIndices();
    fetchStories();
    super.onInit();
  }

  void saveVisitedStoryIndices() {
    GetStorage().write('visitedStoryIndices', visitedStoryIndices);
  }

  void initializeVisitedStoryIndices() {
    final savedIndices = GetStorage().read<List>('visitedStoryIndices') ?? [];
    visitedStoryIndices.assignAll(savedIndices);
  }

  void markAsVisited(index) {
    if (visitedStoryIndices.contains(index)) {
    } else {
      visitedStoryIndices.add(index);
      saveVisitedStoryIndices();
    }
    update();
    DebugLogger.info(visitedStoryIndices.toString());
  }

  void markAsUnvisited(index) {
    if (visitedStoryIndices.contains(index)) {
    } else {
      visitedStoryIndices.remove(index);
    }
    update();
    DebugLogger.info(visitedStoryIndices.toString());
  }

  void updateForSelectedCourse(int courseId) {
    selectedCourseId.value = courseId;
    circularStoryList.clear();
    fetchStories(); // Fetch stories with the new filter
  }

  Future<void> fetchStories() async {
    try {
      isProcessing(true);
      hasError(false);

      // Construct the URL based on whether a course ID is selected
      String url = "${ApiConstants.baseUrl}publishers/story";
      if (selectedCourseId.value != null) {
        url += "/?course_id=${selectedCourseId.value}";
      }

      final response = await HttpService.dioGetRequest(url: url);

      if (response.statusCode == 200) {
        final jsonData = circularStoryModelFromJson(json.encode(response.data));
        circularStoryList.assignAll(jsonData.stories);
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

  Future<void> refreshStories() async {
    if (networkStateController.isInternetConnected.isFalse) {
      DebugLogger.warning("No Internet");
      return;
    }

    if (isProcessing.isFalse || hasError.isTrue) {
      hasError(false);
      circularStoryList.clear();
      await fetchStories();
    }
  }
}
