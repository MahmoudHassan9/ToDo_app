import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_assets.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/light_app_styles.dart';
import 'package:todo_app/data/firebase_services.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/data/models/user_model.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/tasks_tab.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/widgets/task_item.dart';
import 'package:todo_app/providers/settings_tab_provider.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  EasyInfiniteDateTimelineController? controller;
  List<TodoDM> todos = [];
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    getTodosFromFireStore();
  }

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
              child: buildCalenderTimeLine(settingsTabProvider),
            ),
          ],
        ),
        if (todos.isEmpty) noTasksYet(),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => TaskItem(
              model: todos[index],
            ),
            itemCount: todos.length,
          ),
        ),
      ],
    );
  }

  Widget buildCalenderTimeLine(SettingsTabProvider provider) =>
      EasyInfiniteDateTimeLine(
        controller: controller,
        firstDate: DateTime(
          DateTime.now().year,
        ),
        focusDate: selectedDate,
        lastDate: DateTime(
          DateTime.now()
              .add(
                const Duration(
                  days: 365,
                ),
              )
              .year,
        ),
        onDateChange: (dateSelected) {
          selectedDate = dateSelected;
          getTodosFromFireStore();
          setState(() {});
        },
        dayProps: EasyDayProps(
          activeDayStyle: DayStyle(
            monthStrStyle: LightAppStyles.activeCalenderDayMonth,
            dayNumStyle: LightAppStyles.activeCalenderDayNum,
            dayStrStyle: LightAppStyles.activeCalendarDayStr,
            decoration: BoxDecoration(
              color: provider.currentTheme == ThemeMode.light
                  ? AppColors.white
                  : AppColors.blackAccent,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          inactiveDayStyle: DayStyle(
            monthStrStyle: provider.currentTheme == ThemeMode.light
                ? LightAppStyles.inactiveCalenderDayMonth
                : LightAppStyles.inactiveCalenderDayMonth.copyWith(
                    color: Colors.white,
                  ),
            dayNumStyle: provider.currentTheme == ThemeMode.light
                ? LightAppStyles.inactiveCalenderDayNum
                : LightAppStyles.inactiveCalenderDayNum.copyWith(
                    color: Colors.white,
                  ),
            dayStrStyle: provider.currentTheme == ThemeMode.light
                ? LightAppStyles.inactiveCalendarDayStr
                : LightAppStyles.inactiveCalendarDayStr.copyWith(
                    color: Colors.white,
                  ),
            decoration: BoxDecoration(
              color: provider.currentTheme == ThemeMode.light
                  ? AppColors.white
                  : AppColors.blackAccent,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          todayStyle: DayStyle(
            monthStrStyle: provider.currentTheme == ThemeMode.light
                ? LightAppStyles.inactiveCalenderDayMonth
                : LightAppStyles.inactiveCalenderDayMonth.copyWith(
                    color: Colors.white,
                  ),
            dayNumStyle: provider.currentTheme == ThemeMode.light
                ? LightAppStyles.inactiveCalenderDayNum
                : LightAppStyles.inactiveCalenderDayNum.copyWith(
                    color: Colors.white,
                  ),
            dayStrStyle: provider.currentTheme == ThemeMode.light
                ? LightAppStyles.inactiveCalendarDayStr
                : LightAppStyles.inactiveCalendarDayStr.copyWith(
                    color: Colors.white,
                  ),
            decoration: BoxDecoration(
              color: provider.currentTheme == ThemeMode.light
                  ? AppColors.white
                  : AppColors.blackAccent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.blue,
                width: 3,
              ),
            ),
          ),
        ),
        showTimelineHeader: false,
      );

  Future<void> getTodosFromFireStore() async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(TodoDM.collectionName);
    QuerySnapshot querySnapshot = await collectionReference
        .where(
          'dateTime',
          isEqualTo: selectedDate.copyWith(
            hour: 0,
            microsecond: 0,
            millisecond: 0,
            minute: 0,
            second: 0,
          ),
        )
        .get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    todos = documents.map((docSnapShot) {
      Map<String, dynamic> json = docSnapShot.data() as Map<String, dynamic>;
      TodoDM todo = TodoDM.fromJson(json);
      return todo;
    }).toList();
    setState(() {});
  }

  Widget noTasksYet() => Center(
        child: Text(
          'NO Task Yet ! ',
          style: LightAppStyles.settingsTabLabel
              .copyWith(color: Colors.white, fontSize: 25.sp),
        ),
      );
}
