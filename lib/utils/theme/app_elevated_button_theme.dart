import 'package:flutter/material.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      alignment: AlignmentDirectional.center,
      enableFeedback: true,
      shadowColor: Colors.black,
      // side: const BorderSide(
      //   color: Colors.blue,
      //   width: 1.0,
      // ),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      alignment: AlignmentDirectional.center,
      enableFeedback: true,
      shadowColor: Colors.black,
      // side: const BorderSide(
      //   color: Colors.blue,
      //   width: 1.0,
      // ),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}
