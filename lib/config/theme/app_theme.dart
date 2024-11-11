import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_colors.dart';

import '../../core/utils/light_app_styles.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.blue,
    scaffoldBackgroundColor: AppColors.scaffold,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.blue,
      primary: Colors.blue,
    ),
    // useMaterial3: false,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.blue,
      titleTextStyle: LightAppStyles.appBar,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      showSelectedLabels: true,
      selectedItemColor: AppColors.blue,
      unselectedItemColor: AppColors.grey,
      selectedIconTheme: IconThemeData(
        size: 33,
      ),
      unselectedIconTheme: IconThemeData(
        size: 28,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.blue,
      shape: StadiumBorder(
          side: BorderSide(
        color: AppColors.white,
        width: 4,
      )),
    ),
    datePickerTheme: const DatePickerThemeData(
      headerBackgroundColor: AppColors.blue,
      headerForegroundColor: Colors.white,
      backgroundColor: AppColors.white,
    ),
  );
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.blue,
    scaffoldBackgroundColor: AppColors.darkBlue,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.blue,
      primary: Colors.blue,
    ),
    // useMaterial3: false,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.blue,
      titleTextStyle: LightAppStyles.appBar.copyWith(
        color: AppColors.darkBlue,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.blackAccent,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      showSelectedLabels: true,
      selectedItemColor: AppColors.blue,
      unselectedItemColor: AppColors.white,
      selectedIconTheme: IconThemeData(
        size: 33,
      ),
      unselectedIconTheme: IconThemeData(
        size: 28,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.blue,
      shape: StadiumBorder(
        side: BorderSide(
          color: AppColors.white,
          width: 1,
        ),
      ),
    ),
    datePickerTheme: const DatePickerThemeData(
      headerBackgroundColor: AppColors.blue,
      headerForegroundColor: Colors.white,
      backgroundColor: AppColors.blackAccent,
      dividerColor: AppColors.blackAccent,
      dayForegroundColor: WidgetStatePropertyAll(
        Colors.white,
      ),
      yearForegroundColor: WidgetStatePropertyAll(
        Colors.white,
      ),
      todayForegroundColor: WidgetStatePropertyAll(
        Colors.white,
      ),
    ),
  );
}
