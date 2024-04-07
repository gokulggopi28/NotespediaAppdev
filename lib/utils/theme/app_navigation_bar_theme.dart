import 'package:notespedia/utils/constants/app_export.dart';

class AppNavigationBarTheme {
  AppNavigationBarTheme._();

  static NavigationBarThemeData lightNavigationBarTheme =
      NavigationBarThemeData(
    labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const TextStyle(
            color: AppColors.brightGreen,
            fontSize: 12,
          );
        } else {
          return const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          );
        }
      },
    ),
  );

  static NavigationBarThemeData darkNavigationBarTheme = NavigationBarThemeData(
    labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const TextStyle(
            color: AppColors.brightGreen,
            fontSize: 12,
          );
        } else {
          return const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          );
        }
      },
    ),
  );
}
