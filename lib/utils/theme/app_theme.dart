import 'package:flutter/material.dart';
import 'package:notespedia/utils/theme/app_navigation_bar_theme.dart';

import '../constants/app_colors.dart';
import 'app_appbar_theme.dart';
import 'app_bottom_navigation_bar_theme.dart';
import 'app_bottom_sheet_theme.dart';
import 'app_button_theme.dart';
import 'app_checkbox_theme.dart';
import 'app_chip_theme.dart';
import 'app_cupertino_theme.dart';
import 'app_elevated_button_theme.dart';
import 'app_icon_button_theme.dart';
import 'app_icon_theme.dart';
import 'app_outline_button_theme.dart';
import 'app_text_button_theme.dart';
import 'app_text_field_theme.dart';
import 'app_text_theme.dart';

class AppTheme {
  AppTheme._();

  static ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.lightPrimary,
    brightness: Brightness.light,
    // primary: const Color(0xFF2196F3),
    // secondary: const Color(0xFFFFC107),
    // background: Colors.white,
    // surface: Colors.white,
    // onPrimary: Colors.white,
    // onSecondary: Colors.black,
    // onBackground: Colors.black,
    // onSurface: Colors.black,
  );

  static ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.darkPrimary,
    brightness: Brightness.dark,
    // primary: const Color(0xFF2196F3),
    // secondary: const Color(0xFFFFC107),
    // background: const Color(0xFF121212),
    // surface: const Color(0xFF212121),
    // onPrimary: Colors.black,
    // onSecondary: Colors.black,
    // onBackground: Colors.white,
    // onSurface: Colors.white,
  );

  static ThemeData lightTheme = ThemeData(
    colorScheme: lightColorScheme,
    useMaterial3: true,
    fontFamily: "Stolzl",
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    textTheme: AppTextTheme.lightTextTheme,
    buttonTheme: AppButtonTheme.lightButtonTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: AppOutlineButtonTheme.lightOutlineButtonTheme,
    textButtonTheme: AppTextButtonTheme.lightTextButtonTheme,
    iconButtonTheme: AppIconButtonTheme.lightIconButtonTheme,
    inputDecorationTheme: AppTextFieldTheme.lightInputDecorationTheme,
    checkboxTheme: AppCheckBoxTheme.lightCheckboxTheme,
    iconTheme: AppIconTheme.darkIconTheme,
    appBarTheme: AppAppBarTheme.lightAppbarTheme,
    bottomNavigationBarTheme:
        AppBottomNavigationBarTheme.lightBottomNavigationBarTheme,
    chipTheme: AppChipTheme.lightChipTheme,
    bottomSheetTheme: AppBottomSheetTheme.lightBottomSheetTheme,
    cupertinoOverrideTheme: AppCupertinoOverrideTheme.lightCupertinoTheme,
    navigationBarTheme: AppNavigationBarTheme.lightNavigationBarTheme,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: darkColorScheme,
    useMaterial3: true,
    fontFamily: "Stolzl",
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: AppTextTheme.darkTextTheme,
    buttonTheme: AppButtonTheme.darkButtonTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: AppOutlineButtonTheme.darkOutlineButtonTheme,
    textButtonTheme: AppTextButtonTheme.darkTextButtonTheme,
    iconButtonTheme: AppIconButtonTheme.darkIconButtonTheme,
    inputDecorationTheme: AppTextFieldTheme.darkInputDecorationTheme,
    checkboxTheme: AppCheckBoxTheme.darkCheckboxTheme,
    iconTheme: AppIconTheme.darkIconTheme,
    appBarTheme: AppAppBarTheme.darkAppbarTheme,
    bottomNavigationBarTheme:
        AppBottomNavigationBarTheme.darkBottomNavigationBarTheme,
    chipTheme: AppChipTheme.darkChipTheme,
    bottomSheetTheme: AppBottomSheetTheme.darkBottomSheetTheme,
    cupertinoOverrideTheme: AppCupertinoOverrideTheme.lightCupertinoTheme,
    navigationBarTheme: AppNavigationBarTheme.darkNavigationBarTheme,
  );
}
