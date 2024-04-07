import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: const TextStyle().copyWith(
      fontSize: 64,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      height: 1.4,
    ),
    displayMedium: const TextStyle().copyWith(
      fontSize: 52,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      height: 1.4,
    ),
    displaySmall: const TextStyle().copyWith(
      fontSize: 42,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      height: 1.4,
    ),
    headlineLarge: const TextStyle().copyWith(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      height: 1.4,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: 1.4,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: 1.4,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: 1.4,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      height: 1.4,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black,
      height: 1.4,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black,
      height: 1.4,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black,
      height: 1.4,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black.withOpacity(0.5),
      height: 1.4,
    ),
    labelLarge: const TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.black,
      height: 1.4,
    ),
    labelMedium: const TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.black.withOpacity(0.5),
      height: 1.4,
    ),
    labelSmall: const TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: Colors.black.withOpacity(0.5),
      height: 1.4,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: const TextStyle().copyWith(
      fontSize: 64,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      height: 1.4,
    ),
    displayMedium: const TextStyle().copyWith(
      fontSize: 52,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      height: 1.4,
    ),
    displaySmall: const TextStyle().copyWith(
      fontSize: 42,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      height: 1.4,
    ),
    headlineLarge: const TextStyle().copyWith(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      height: 1.4,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      height: 1.4,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: 1.4,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      height: 1.4,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      height: 1.4,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      height: 1.4,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      height: 1.4,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      height: 1.4,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.white.withOpacity(0.5),
      height: 1.4,
    ),
    labelLarge: const TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      height: 1.4,
    ),
    labelMedium: const TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.white.withOpacity(0.5),
      height: 1.4,
    ),
    labelSmall: const TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: Colors.white.withOpacity(0.5),
      height: 1.4,
    ),
  );
}
