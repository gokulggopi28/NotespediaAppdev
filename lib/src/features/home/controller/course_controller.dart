import 'package:dio/dio.dart';
import 'package:notespedia/utils/constants/app_export.dart';

import '../../../../models/course_selection_model.dart';

class CourseController extends GetxController {
  var courses = <Course>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  void fetchCourses() async {
    try {
      var response =
          await Dio().get('http://139.59.38.234/api/common/courses/');
      if (response.statusCode == 200) {
        var serverCourses =
            List<Map<String, dynamic>>.from(response.data['data']['courses']);
        courses.value = serverCourses
            .map((courseData) => Course.fromJson(courseData))
            .toList();
      } else {
        print('Failed to fetch courses: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching courses: $e');
    }
  }
}
