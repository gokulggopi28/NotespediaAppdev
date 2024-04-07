import 'package:flutter/material.dart';

class AppBottomNavigationBarTheme {
  AppBottomNavigationBarTheme._();

  static const lightBottomNavigationBarTheme = BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );

  static const darkBottomNavigationBarTheme = BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 14,
    ),
  );
}
