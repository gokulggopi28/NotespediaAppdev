import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeviceHelper {
  //
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static bool isLightMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double responsivePadding(BuildContext context, double value) {
    return MediaQuery.of(context).size.width * (value / 375.0);
  }

  static double responsiveRadius(BuildContext context, double value) {
    return MediaQuery.of(context).size.width * (value / 375.0);
  }

  static double responsiveWidth(BuildContext context, double value) {
    return MediaQuery.of(context).size.width * (value / 375.0);
  }

  static double responsiveHeight(BuildContext context, double value) {
    return MediaQuery.of(context).size.height * (value / 812.0);
  }

  static double responsiveFontSize(BuildContext context, double fontSize) {
    return MediaQuery.of(context).size.width * (fontSize / 375.0);
  }

  // Function to set the status bar style
  static Future<void> setStatusBarStyle({
    Color statusBarColor = Colors.transparent,
    Brightness statusBarIconBrightness = Brightness.dark,
    Color systemNavigationBarColor = Colors.transparent,
    Brightness systemNavigationBarIconBrightness = Brightness.dark,
  }) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
        systemNavigationBarColor: systemNavigationBarColor,
        systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
      ),
    );
  }

  // Status bar Color
  static Future<void> setStatusBarColor(Color statusBarColor) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: statusBarColor),
    );
  }

  // Navbar Style
  static Future<void> setSystemNavigationBarColor(
      Color systemNavigationBarColor) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: systemNavigationBarColor),
    );
  }

  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
        enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  }

  static double getPixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  static double getBottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }

  static double getKeyboardHeight(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return viewInsets.bottom;
  }

  static Future<bool> isKeyboardVisible(BuildContext context) async {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom > 0;
  }

  static bool isLandscapeOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom == 0;
  }

  static bool isPortraitOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom != 0;
  }

  static Future<bool> isPhysicalDevice() async {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

  static Future<void> setPreferredOrientation(
      List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  static bool isIOS() {
    return Platform.isIOS;
  }

  static bool isAndroid() {
    return Platform.isAndroid;
  }

  static bool isWindows() {
    return Platform.isWindows;
  }
}
