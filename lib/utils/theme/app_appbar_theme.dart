import 'package:flutter/material.dart';

class AppAppBarTheme {
  AppAppBarTheme._();

  static const lightAppbarTheme = AppBarTheme(
    centerTitle: false,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    foregroundColor: Colors.black,
    elevation: 0,
    scrolledUnderElevation: 0,
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 24,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
      size: 24,
    ),
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  static const darkAppbarTheme = AppBarTheme(
    centerTitle: false,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    foregroundColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 24,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
      size: 24,
    ),
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );
}
