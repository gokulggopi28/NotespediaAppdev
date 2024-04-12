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
    var coursesJson = json['data']['courses'] as List;
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
  final int
      isDefault; // Include handling for 'is_default' as it's present in your JSON.

  CourseList(
      {required this.courseId,
      required this.courseName,
      required this.isDefault});

  factory CourseList.fromJson(Map<String, dynamic> json) => CourseList(
        courseId: json["id"],
        courseName: json["name"],
        isDefault: json["is_default"], // Parsing 'is_default' correctly.
      );

  Map<String, dynamic> toJson() => {
        "id": courseId,
        "name": courseName,
        "is_default": isDefault, // Ensuring it's returned as part of the JSON.
      };
}
