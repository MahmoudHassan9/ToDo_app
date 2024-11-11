import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/extensions/date_time_ex.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_dialogs.dart';
import 'package:todo_app/core/utils/light_app_styles.dart';
import 'package:todo_app/data/firebase_services.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/data/models/user_model.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/widgets/custom_button.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/widgets/custom_text_form_field.dart';
import 'package:todo_app/providers/settings_tab_provider.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => AddBottomSheetState();

  static Future show(context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      builder: (context) => const AddBottomSheet(),
    );
  }
}

class AddBottomSheetState extends State<AddBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Provider.of<SettingsTabProvider>(context).currentTheme ==
              ThemeMode.light
          ? AppColors.white
          : AppColors.darkBlue,
      padding: EdgeInsets.only(
        top: 22,
        left: 16,
        right: 16,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 22,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add new Task',
              style: LightAppStyles.poppinsFontWeight700Size18,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextFormField(
              hintText: 'Enter Task Name',
              controller: titleController,
              filledColor:
                  Provider.of<SettingsTabProvider>(context).currentTheme ==
                          ThemeMode.dark
                      ? AppColors.blackAccent
                      : null,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Task name required...';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextFormField(
              hintText: 'Description...',
              controller: descriptionController,
              filledColor:
              Provider.of<SettingsTabProvider>(context).currentTheme ==
                  ThemeMode.dark
                  ? AppColors.blackAccent
                  : null,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Description required...';
                }
                return null;
              },
              maxLines: 7,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Select Date :',
              style: LightAppStyles.poppinsFontWeight700Size18,
            ),
            TextButton(
              onPressed: () async {
                var date = await showTimePickerr(
                  context,
                );
                if (date != null) {
                  selectedDate = date;
                  setState(() {});
                }
              },
              child: Text(
                selectedDate.formattedDate,
                style: LightAppStyles.hintText.copyWith(
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Add Task',
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;
                  AppDialogs.showDialogWaiting(context);
                  await setTodosToFireStore();
                  if (context.mounted) {
                    AppDialogs.removeDialog(context);
                    AppDialogs.showMessage(
                      context,
                      message: 'Added Successfully',
                      color: Colors.green,
                    );
                  }

                  titleController.clear();
                  descriptionController.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<DateTime?> showTimePicker(context) {
  //   return showDatePicker(
  //     context: context,
  //     firstDate: DateTime.now(),
  //     initialDate: selectedDate,
  //     lastDate: DateTime.now().add(
  //       const Duration(
  //         days: 365,
  //       ),
  //     ),
  //   );
  // }

  Future<void> setTodosToFireStore() async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(TodoDM.collectionName);
    DocumentReference documentReference = collectionReference.doc();

    TodoDM model = TodoDM(
      title: titleController.text,
      description: descriptionController.text,
      id: documentReference.id,
      dateTime: selectedDate.copyWith(
        millisecond: 0,
        microsecond: 0,
        minute: 0,
        hour: 0,
        second: 0,
      ),
    );
    documentReference.set(model.toJson()).then((val) {
      if (mounted) Navigator.of(context).pop();
    });
  }

  Future<DateTime?> showTimePickerr(
    context,
  ) {
    return showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: selectedDate,
      lastDate: DateTime.now().add(
        const Duration(
          days: 365,
        ),
      ),
    );
  }
}
