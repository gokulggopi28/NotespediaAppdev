import 'dart:io';

import 'package:intl/intl.dart';
import 'package:notespedia/utils/constants/app_export.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class HelperFunctions {
  //

  static Future<void> launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw "Could not launch $url";
    }
  }

  static void showSnackBar({
    required BuildContext context,
    required String message,
    int? seconds,
    SnackBarBehavior? behavior,
  }) {
    ScaffoldMessenger.of(context)
        .removeCurrentSnackBar(); // Remove current SnackBar

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        backgroundColor: Colors.black,
        closeIconColor: Colors.white,
        showCloseIcon: true,
        behavior: behavior ?? SnackBarBehavior.fixed,
        elevation: 3,
        duration: Duration(seconds: seconds ?? 1),
        content: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Text(
            message,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 14,
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }

  static void showTopSnackBar({
    required BuildContext context,
    required String message,
    String? title,
    int? seconds,
  }) {
    // Get.closeAllSnackbars();
    Get.closeCurrentSnackbar();
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: seconds ?? 1),
      backgroundColor: Colors.black,
      colorText: Colors.white,
      isDismissible: true,
      borderRadius: 8.0,
      padding: const EdgeInsets.only(
          left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
      margin: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      icon: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Image.asset(
          AppImages.appLogo,
        ),
      ),
      titleText: Text(
        title ?? "Network Status",
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white,
            ),
      ),
      messageText: Text(
        message,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }

  static void showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static Future<bool> hasInternetConnections() async {
    try {
      final result = await InternetAddress.lookup("example.com");
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return "${text.substring(0, maxLength)}...";
    }
  }

  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return "";
    }
    String lowerCasedText = text.toLowerCase();
    String capitalizedText = lowerCasedText.substring(0, 1).toUpperCase() +
        lowerCasedText.substring(1);

    return capitalizedText;
  }

  static String formatReadCount(int count) {
    if (count < 1000) {
      return '$count';
    } else if (count < 1000000) {
      double kCount = count / 1000.0;
      return "${kCount.toStringAsFixed(kCount.truncateToDouble() == kCount ? 0 : 1)} k";
    } else {
      double mCount = count / 1000000.0;
      return "${mCount.toStringAsFixed(mCount.truncateToDouble() == mCount ? 0 : 1)} m";
    }
  }

  static String getFormattedDate(DateTime date,
      {String format = "dd MMM yyyy"}) {
    return DateFormat(format).format(date);
  }

  static String extractDateAndTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  static String extractDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String extractTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('HH:mm').format(dateTime);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i = i + rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(
        Row(
          children: rowChildren,
        ),
      );
    }
    return wrappedList;
  }

  static Color? getColor(String value) {
    if (value == "Green") {
      return Colors.green;
    } else if (value == "Orange") {
      return Colors.orange;
    } else if (value == "Red") {
      return Colors.red;
    } else if (value == "Blue") {
      return Colors.blue;
    } else if (value == "Yellow") {
      return Colors.yellow;
    } else if (value == "Pink") {
      return Colors.pink;
    } else if (value == "Grey") {
      return Colors.grey;
    } else if (value == "Purple") {
      return Colors.purple;
    } else if (value == "Black") {
      return Colors.black;
    } else if (value == "White") {
      return Colors.white;
    } else {
      return null;
    }
  }

  Future<bool> isUserHavingActivePremiumSubscription(String productId) async {
    try {
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      return  customerInfo.activeSubscriptions.contains(productId);
      // access latest customerInfo
    } on PlatformException catch (e) {
      // Error fetching customer info
      return false;
    }
  }

}
