import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/home/tabs/settings_tab/settings_tab.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/tasks_tab.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/widgets/add_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = const [
    TasksTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Text(
            'To DO List',
          ),
        ),
      ),
      body: tabs[currentIndex],
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavBar(),
    );
  }

  Widget buildBottomNavBar() => BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_outlined,
              ),
              label: 'Settings',
            ),
          ],
        ),
      );

  Widget buildFloatingActionButton() => FloatingActionButton(
        onPressed: () => AddBottomSheet.show(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      );
}
