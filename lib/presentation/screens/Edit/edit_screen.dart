import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/extensions/date_time_ex.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_dialogs.dart';
import 'package:todo_app/core/utils/light_app_styles.dart';
import 'package:todo_app/data/firebase_services.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/data/models/user_model.dart';
import 'package:todo_app/presentation/screens/home/home_screen.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/widgets/custom_button.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/widgets/custom_text_form_field.dart';
import 'package:todo_app/providers/settings_tab_provider.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key, required this.model});

  final TodoDM model;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController titleController;

  late TextEditingController descController;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.model.dateTime!;
    titleController = TextEditingController();
    descController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Text(
            'Edit Task :',
            style: LightAppStyles.poppinsFontWeight700Size18,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomTextFormField(
            hintText: 'Task title',
            controller: titleController,
            filledColor:
                Provider.of<SettingsTabProvider>(context).currentTheme ==
                        ThemeMode.dark
                    ? AppColors.blackAccent
                    : null,
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomTextFormField(
            hintText: 'Task description',
            controller: descController,
            filledColor:
                Provider.of<SettingsTabProvider>(context).currentTheme ==
                        ThemeMode.dark
                    ? AppColors.blackAccent
                    : null,
          ),
          SizedBox(
            height: 10.h,
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
            height: 25.h,
          ),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Delete',
                  color: Colors.red,
                  onPressed: () {
                    MyFireBaseServices.deleteTodo(
                      id: widget.model.id!,
                    );
                    tasksTabKey.currentState?.getTodosFromFireStore();
                    AppDialogs.showMessage(
                      context,
                      message: 'Deleted Successfully',
                      color: Colors.red,
                    );
                    AppDialogs.removeDialog(context);
                  },
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: CustomButton(
                  text: 'Done',
                  onPressed: () async {
                    await update();
                    tasksTabKey.currentState?.getTodosFromFireStore();
                    if (context.mounted) {
                      AppDialogs.showMessage(
                        context,
                        message: 'Updated Successfully',
                        color: Colors.green,
                      );
                      AppDialogs.removeDialog(context);
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> update() async {
    TodoDM model = TodoDM(
      description: descController.text.isEmpty
          ? widget.model.description
          : descController.text,
      title: titleController.text.isEmpty
          ? widget.model.title
          : titleController.text,
      id: widget.model.id,
      dateTime: selectedDate,
      isDone: widget.model.isDone,
    );
    await FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(TodoDM.collectionName)
        .doc(widget.model.id)
        .update(model.toJson());
  }

  Future<DateTime?> showTimePickerr(context) {
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
