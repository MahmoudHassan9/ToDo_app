import 'package:flutter/material.dart';
import 'package:todo_app/core/app_colors.dart';

import '../../core/light_app_styles.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    primaryColor: AppColors.blue,
    scaffoldBackgroundColor: AppColors.scaffold,
    useMaterial3: false,
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
  );
  static ThemeData dark = ThemeData(
    appBarTheme: const AppBarTheme(color: Colors.black, centerTitle: true),
  );
}
