// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';

CourseModel courseModelFromJson(String str) =>
    CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
  final List<CourseList> course;

  CourseModel({required this.course});

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    var coursesJson =
        json['data']['courses'] as List; // Navigate through 'data' to 'courses'
    List<CourseList> coursesList = coursesJson
        .map((courseJson) => CourseList.fromJson(courseJson))
        .toList();
    return CourseModel(course: coursesList);
  }

  Map<String, dynamic> toJson() => {
        "data": {
          "courses": List<dynamic>.from(course.map((x) => x.toJson())),
        },
      };
}

class CourseList {
  final int courseId;
  final String courseName;

  CourseList({required this.courseId, required this.courseName});

  factory CourseList.fromJson(Map<String, dynamic> json) => CourseList(
        courseId: json["id"],
        courseName: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": courseId,
        "name": courseName,
      };
}
