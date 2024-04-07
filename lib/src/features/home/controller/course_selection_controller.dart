import 'dart:convert';

import 'package:notespedia/repositories/user_preferences.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class CourseSelectionController extends GetxController {
  //
  final networkStateController = Get.put(NetworkStateController());

  var isProcessing = false.obs;
  var hasError = false.obs;
  var isEmpty = false.obs;
  final authController = Get.find<AuthenticationController>();
  var selectedIndex = 0.obs;
  var courseList = <CourseList>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  void onCourseSelection(int index) {
    selectedIndex.value = index;
    int courseId =
        courseList[index].courseId; // Adjust based on your data structure

    Get.find<FreshReleaseController>().updateForSelectedCourse(courseId);
    Get.find<CircularStoryController>().selectedCourseId.value = courseId;
    Get.find<TopReadsController>().selectedCourseId.value = courseId;
    Get.find<StaffPublisherController>().selectedCourseId.value = courseId;
    Get.find<BooksCategoryController>().selectedCourseId.value = courseId;
    // Trigger data fetching with the new course filter
    Get.find<FreshReleaseController>().fetchFreshReleaseBooks();
    Get.find<CircularStoryController>().fetchStories();
    Get.find<StaffPublisherController>().fetchStaffPublisher();
    Get.find<TopReadsController>().fetchTopReadBooks(1);
    Get.find<BooksCategoryController>().fetchCategoryBooks();
  }

  void setSelectedCourseByName(String courseName) {
    int index =
        courseList.indexWhere((course) => course.courseName == courseName);
    if (index != -1) {
      selectedIndex.value = index;
      // Notify FreshReleaseController about the course change
      int courseId =
          courseList[index].courseId; // Adjust based on your data structure
      Get.find<FreshReleaseController>().updateForSelectedCourse(courseId);
      Get.find<CircularStoryController>().updateForSelectedCourse(courseId);
      Get.find<StaffPublisherController>().updateForSelectedCourse(courseId);
    }
  }

  Future<void> fetchCourses() async {
    if (networkStateController.isInternetConnected.isTrue) {
      try {
        isProcessing(true);
        hasError(false);
        final response = await HttpService.dioGetRequest(
            url: "${ApiConstants.baseUrl}common/courses");

        if (response.statusCode == 200) {
          var jsonData = courseModelFromJson(json.encode(response.data));
          courseList.addAll(jsonData.course);
        } else {
          DebugLogger.warning('Error fetching courses: ${response.statusCode}');
          hasError(true);
        }
      } catch (error) {
        DebugLogger.error(error.toString());
        hasError(true);
      } finally {
        isProcessing(false);
      }
    } else {
      DebugLogger.warning("No Internet");
      hasError(true);
    }

    if (courseList.isEmpty ||
        !(authController.isLoggedIn.isTrue && UserPreferences.userId > 0)) {
      // Initialize defaultCourse here to ensure its availability outside the if block
      CourseList defaultCourse = CourseList(courseId: 1, courseName: "Medical");

      // Check if "Medical" is already in the list to avoid duplicates
      int existingIndex =
          courseList.indexWhere((c) => c.courseName == "Medical");
      if (existingIndex == -1) {
        courseList.add(defaultCourse);
        // Update the index of "Medical" in courseList
        existingIndex = courseList.indexWhere((c) => c.courseName == "Medical");
      }
      selectedIndex.value = existingIndex;

      int defaultCourseId =
          defaultCourse.courseId; // Now defaultCourse is accessible here

      // Update selectedCourseId in all related controllers:
      Get.find<FreshReleaseController>().selectedCourseId.value =
          defaultCourseId;
      Get.find<CircularStoryController>().selectedCourseId.value =
          defaultCourseId;
      Get.find<TopReadsController>().selectedCourseId.value = defaultCourseId;
      Get.find<StaffPublisherController>().selectedCourseId.value =
          defaultCourseId;
      Get.find<BooksCategoryController>().selectedCourseId.value =
          defaultCourseId;
      Get.find<FreshReleaseController>().fetchFreshReleaseBooks();
      Get.find<CircularStoryController>().fetchStories();
      Get.find<StaffPublisherController>().fetchStaffPublisher();
      Get.find<TopReadsController>().fetchTopReadBooks(1);
      Get.find<BooksCategoryController>().fetchCategoryBooks();
    }
  }

  Future<void> refreshCourses() async {
    if (networkStateController.isInternetConnected.isTrue) {
      if (isProcessing.isFalse) {
        hasError(false);
        courseList.clear();
        await fetchCourses();
      } else if (hasError.isTrue) {
        hasError(false);
        courseList.clear();
        await fetchCourses();
      }
    } else {
      return;
    }
  }
}
