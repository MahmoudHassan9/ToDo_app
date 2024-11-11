import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/light_app_styles.dart';
import 'package:todo_app/presentation/screens/home/tabs/settings_tab/settings_tab.dart';
import 'package:todo_app/presentation/screens/home/tabs/settings_tab/widgets/settings_tab_widget.dart';
import 'package:todo_app/routing/app_routes.dart';

import '../../../../../providers/settings_tab_provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    SettingsTabProvider settingsTabProvider = Provider.of(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: AppColors.blue,
              height: 75.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 30.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 25,
                      bottom: 17,
                      left: 38,
                    ),
                    child: Text(
                      'Language',
                      style: Provider.of<SettingsTabProvider>(context)
                          .currentTheme ==
                          ThemeMode.light
                          ? LightAppStyles.settingsTabLabel
                          : LightAppStyles.settingsTabLabel.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  BuildSettingWidget(
                    text: settingsTabProvider.lang,
                    widget: buildDropdownButton(
                      context: context,
                      settingsTabProvider: settingsTabProvider,
                      title1: 'English',
                      title2: 'العربية',
                      val1: 'en',
                      val2: 'ar',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 17,
                      left: 38,
                    ),
                    child: Text(
                      'Mode',
                      style: Provider.of<SettingsTabProvider>(context)
                          .currentTheme ==
                          ThemeMode.light
                          ? LightAppStyles.settingsTabLabel
                          : LightAppStyles.settingsTabLabel.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  BuildSettingWidget(
                    text: settingsTabProvider.theme,
                    widget: buildDropdownButton(
                      context: context,
                      settingsTabProvider: settingsTabProvider,
                      title1: 'Light',
                      title2: 'Dark',
                      val1: 'light',
                      val2: 'dark',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 25,
                      bottom: 17,
                      left: 38,
                    ),
                    child: Text(
                      'Logout',
                      style: Provider.of<SettingsTabProvider>(context)
                                  .currentTheme ==
                              ThemeMode.light
                          ? LightAppStyles.settingsTabLabel
                          : LightAppStyles.settingsTabLabel.copyWith(
                              color: Colors.white,
                            ),
                    ),
                  ),
                  BuildSettingWidget(
                    text: 'logout',
                    widget: IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.login);
                      },
                      icon: const Icon(
                        Icons.logout,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  DropdownButton<String> buildDropdownButton({
    required BuildContext context,
    required SettingsTabProvider settingsTabProvider,
    required String val1,
    required String title1,
    required String val2,
    required String title2,
  }) {
    return DropdownButton<String>(
      underline: Container(),
      iconEnabledColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      dropdownColor: Theme.of(context).primaryColor,
      value: val1 == 'en'
          ? settingsTabProvider.languageCode
          : settingsTabProvider.isLight
              ? 'light'
              : 'dark',
      items: [
        DropdownMenuItem(
          value: val1,
          child: Text(
            title1,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        DropdownMenuItem(
          value: val2,
          child: Text(
            title2,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
      onChanged: (value) {
        // print(value);
        if (value == 'light' || value == 'dark') {
          settingsTabProvider.changeTheme(value);
        } else {
          settingsTabProvider.changeLanguage(value);
        }
      },
    );
  }
}
