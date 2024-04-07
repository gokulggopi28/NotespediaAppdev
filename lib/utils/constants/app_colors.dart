import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // App Basic Colors
  static const Color lightPrimary = Color(0xff09cf64);
  static const Color darkPrimary = Color(0xff09cf64);

  // Text Colors
  static const Color textWhite = Colors.white;
  static const Color textBlack = Colors.black;

  // Main
  static const Color lightBackground = Color(0xfffafafa);
  static const Color darkBackground = Color(0xff000000);
  static const Color brightGreen = Color(0xff09cf64);
  static const Color dimGreen = Color(0xffeaf4f1);

  // Icon
  static const Color greyBrightIconColor = Color(0xff757575);
  static const Color greyDimIconColor = Color(0xffb8b8b8);
  static Color badgeIconColor = Colors.red.shade300;

  // Border
  static const Color greyBright = Color(0xff757575);
  static const Color greyDim = Color(0xffb8b8b8);

  static BoxShadow containerShadow = BoxShadow(
    color: Colors.grey.shade300,
    blurRadius: 6,
    offset: const Offset(1, 3),
  );

  static BoxShadow dimContainerShadow = BoxShadow(
    color: Colors.grey.shade300.withOpacity(.6),
    blurRadius: 6,
    offset: const Offset(1, 3),
  );

  static const greenIndicator = Color(0xff09cf64);
  static Color yellowIndicator = Colors.yellow.shade600;
  static Color redIndicator = Colors.red;

  // Button Colors
  // static const Color buttonPrimary = Color(0xff4b68ff);
  // static const Color buttonSecondary = Color(0xff6c757d);
  // static const Color buttonDisabled = Color(0xffc4c4c4);

  // Gradient Colors
  // static const Gradient linearGradient = LinearGradient(
  //   begin: Alignment(0.0, 0.0),
  //   end: Alignment(0.707, -0.707),
  //   colors: [
  //     Color(0xffff9a9e),
  //     Color(0xfffad0c4),
  //     Color(0xfffad0c4),
  //   ],
  // );
}
