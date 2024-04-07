import 'package:flutter/material.dart';

class AppTextButtonTheme {
  AppTextButtonTheme._();

  static final lightTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      // foregroundColor: Colors.black,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );

  static final darkTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      // foregroundColor: Colors.white,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}
