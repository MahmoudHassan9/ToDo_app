import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/extensions/date_time_ex.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_dialogs.dart';
import 'package:todo_app/core/utils/light_app_styles.dart';
import 'package:todo_app/data/firebase_services.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/presentation/screens/Edit/edit_screen.dart';
import 'package:todo_app/presentation/screens/home/home_screen.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/widgets/add_bottom_sheet.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/widgets/custom_button.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/widgets/custom_text_form_field.dart';
import 'package:todo_app/providers/settings_tab_provider.dart';

abstract class AppDialogs {
  static void showMessage(context,
          {required String message, required Color color}) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: LightAppStyles.settingsTabLabel.copyWith(
                color: AppColors.white,
                fontSize: 18,
              ),
            ),
          ),
          backgroundColor: color,
          dismissDirection: DismissDirection.horizontal,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          margin: const EdgeInsets.all(8),
          behavior: SnackBarBehavior.floating,
        ),
      );

  static void showDialogWaiting(context) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor:
              Provider.of<SettingsTabProvider>(context).currentTheme ==
                      ThemeMode.dark
                  ? AppColors.darkBlue
                  : null,
          title: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );

  static void showEditDialog(context, {TodoDM? model}) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor:
          Provider.of<SettingsTabProvider>(context).currentTheme ==
              ThemeMode.dark
              ? AppColors.darkBlue
              : null,
          title: EditTaskScreen(
            model: model!,
          ),
        ),
      );

  static void removeDialog(context) => Navigator.pop(context);
}
