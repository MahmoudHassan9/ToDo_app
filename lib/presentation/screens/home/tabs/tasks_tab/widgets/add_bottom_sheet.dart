import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/extensions/date_time_ex.dart';
import 'package:todo_app/core/utils/light_app_styles.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/widgets/custom_button.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/widgets/custom_text_form_field.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();

  static void show(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
      ),
      builder: (context) => const AddBottomSheet(),
    );
  }
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 22,
        left: 16,
        right: 16,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 22,
      ),
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
            controller: taskController,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            hintText: 'Description...',
            controller: descriptionController,
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
              var date = await showTimePicker(context);
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
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> showTimePicker(context) {
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
