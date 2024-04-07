import 'package:flutter/foundation.dart';

class LocalCourseSelectionModel {
  LocalCourseSelectionModel({
    required this.text,
    required this.onTap,
    required this.isSelected,
  });

  final String text;
  final VoidCallback onTap;
  final bool isSelected;
}

// List<CourseSelectionModel> courseSelectionList = [
//   CourseSelectionModel(
//     text: 'Medical',
//     onTap: () {
//       if (kDebugMode) {
//         print('Button 1 Pressed!');
//       }
//     },
//   ),
//   CourseSelectionModel(
//     text: 'Engineering',
//     onTap: () {
//       if (kDebugMode) {
//         print('Button 2 Pressed!');
//       }
//     },
//   ),
//   CourseSelectionModel(
//     text: 'UPSC',
//     onTap: () {
//       if (kDebugMode) {
//         print('Button 3 Pressed!');
//       }
//     },
//   ),
//   CourseSelectionModel(
//     text: 'NEET UG',
//     onTap: () {
//       if (kDebugMode) {
//         print('Button 4 Pressed!');
//       }
//     },
//   ),
//   CourseSelectionModel(
//     text: 'Kerala PSC',
//     onTap: () {
//       if (kDebugMode) {
//         print('Button 4 Pressed!');
//       }
//     },
//   ),
// ];
