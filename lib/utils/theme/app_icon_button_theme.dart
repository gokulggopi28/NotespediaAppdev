import 'package:flutter/material.dart';

class AppIconButtonTheme {
  AppIconButtonTheme._();

  static final lightIconButtonTheme = IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: Colors.black,
      iconSize: 24,
    ),
  );

  static final darkIconButtonTheme = IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: Colors.white,
      iconSize: 24,
    ),
  );
}
