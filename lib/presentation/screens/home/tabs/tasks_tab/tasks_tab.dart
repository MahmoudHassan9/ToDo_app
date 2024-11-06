import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/core/utils/app_assets.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/light_app_styles.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/tasks_tab.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/widgets/task_item.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  EasyInfiniteDateTimelineController? controller;
  DateTime selectedDate = DateTime.now();
  List<TodoDM> todos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodosFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
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
              child: buildCalenderTimeLine(),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => TaskItem(
              model: todos[index],
              onDelete: () {
                getTodosFromFireStore();
              },
            ),
            itemCount: todos.length,
          ),
        ),
      ],
    );
  }

  Widget buildCalenderTimeLine() => EasyInfiniteDateTimeLine(
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
        },
        dayProps: EasyDayProps(
          activeDayStyle: DayStyle(
            monthStrStyle: LightAppStyles.calenderDayMonth,
            dayNumStyle: LightAppStyles.calenderDayNum,
            dayStrStyle: LightAppStyles.calendarDayStr,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          inactiveDayStyle: DayStyle(
            monthStrStyle: LightAppStyles.calenderDayMonth.copyWith(
              color: Colors.black,
            ),
            dayNumStyle: LightAppStyles.calenderDayNum.copyWith(
              color: Colors.black,
            ),
            dayStrStyle: LightAppStyles.calendarDayStr.copyWith(
              color: Colors.black,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          todayStyle: DayStyle(
            monthStrStyle: LightAppStyles.calenderDayMonth.copyWith(
              color: Colors.black,
            ),
            dayNumStyle: LightAppStyles.calenderDayNum.copyWith(
              color: Colors.black,
            ),
            dayStrStyle: LightAppStyles.calendarDayStr.copyWith(
              color: Colors.black,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
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
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(TodoDM.collectionName);
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
}
