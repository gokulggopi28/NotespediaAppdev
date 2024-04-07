import 'package:flutter/material.dart';

class AppOutlineButtonTheme {
  AppOutlineButtonTheme._();

  static final lightOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      side: const BorderSide(
        color: Colors.blue,
        width: 1.0,
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 16.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );

  static final darkOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      side: const BorderSide(
        color: Colors.blueAccent,
        width: 1.0,
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 16.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}
