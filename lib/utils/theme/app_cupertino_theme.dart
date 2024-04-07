import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppCupertinoOverrideTheme {
  AppCupertinoOverrideTheme._();

  static const CupertinoThemeData lightCupertinoTheme = CupertinoThemeData(
    textTheme: CupertinoTextThemeData(
      dateTimePickerTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
        fontWeight: FontWeight.w400,
      ),
      pickerTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static const CupertinoThemeData darkCupertinoTheme = CupertinoThemeData(
    textTheme: CupertinoTextThemeData(
      dateTimePickerTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
        fontWeight: FontWeight.w400,
      ),
      pickerTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
