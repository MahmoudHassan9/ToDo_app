import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsTabProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;

  bool get isLight => currentTheme == ThemeMode.light;

  String get theme => currentTheme == ThemeMode.light ? 'Light' : 'Dark';

  String get lang => languageCode == 'en' ? 'English' : 'العربية';

  void changeTheme(String? val) {
    if ((val == null) ||
        (theme == 'Dark' && val == 'dark') ||
        (theme == 'Light' && val == 'light')) return;
    if (val == 'dark') {
      currentTheme = ThemeMode.dark;
    } else {
      currentTheme = ThemeMode.light;
    }
    saveTheme();
    notifyListeners();
  }

  void saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (currentTheme == ThemeMode.dark) {
      prefs.setString('theme', 'isDark');
    } else {
      prefs.setString('theme', 'isLight');
    }
  }

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String saveTheme = prefs.getString('theme') ?? 'isLight';
    if (saveTheme == 'isDark') {
      currentTheme = ThemeMode.dark;
    } else {
      currentTheme = ThemeMode.light;
    }
    notifyListeners();
  }

  String languageCode = 'en';

  void changeLanguage(String? value) {
    languageCode = value ?? languageCode;
    saveLanguage();
    notifyListeners();
  }

  void saveLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (languageCode == 'en') {
      prefs.setString('lang', 'en');
    } else {
      prefs.setString('lang', 'ar');
    }
  }

  void getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString('lang') ?? 'en';
    if (lang == 'en') {
      languageCode = 'en';
    } else {
      languageCode = 'ar';
    }
    notifyListeners();
  }
}
