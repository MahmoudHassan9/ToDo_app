import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_assets.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_dialogs.dart';
import 'package:todo_app/core/utils/light_app_styles.dart';
import 'package:todo_app/data/firebase_services.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/data/models/user_model.dart';
import 'package:todo_app/presentation/screens/home/home_screen.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/tasks_tab.dart';
import 'package:todo_app/providers/settings_tab_provider.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.model,
  });

  final TodoDM model;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    SettingsTabProvider provider = Provider.of(context);
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: provider.currentTheme == ThemeMode.light
            ? Colors.white
            : AppColors.blackAccent,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              onPressed: (context) {
                MyFireBaseServices.deleteTodo(
                  context,
                  id: widget.model.id!,
                );
                tasksTabKey.currentState!.getTodosFromFireStore();
                AppDialogs.showMessage(
                  context,
                  message: 'Deleted successfully',
                  color: Colors.red,
                );
              },
              backgroundColor: AppColors.red,
              foregroundColor: AppColors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) {
                AppDialogs.showEditDialog(
                  context,
                  model: widget.model,
                );
              },
              backgroundColor: AppColors.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            color: provider.currentTheme == ThemeMode.light
                ? Colors.white
                : AppColors.blackAccent,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: buildListTileLeading(),
            title: Text(
              widget.model.title!,
              style: LightAppStyles.poppinsFontWeight700Size18.copyWith(
                color: widget.model.isDone! ? Colors.green : Colors.blue,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              widget.model.description!,
              style: provider.theme == 'isLight'
                  ? LightAppStyles.taskItemDesc
                  : LightAppStyles.taskItemDesc.copyWith(
                      color: Colors.white,
                    ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            trailing: buildListTileTrailing(),
          ),
        ),
      ),
    );
  }

  InkWell buildListTileTrailing() {
    return InkWell(
      onTap: () async {
        widget.model.isDone = !widget.model.isDone!;
        await update();
        setState(() {});
      },
      child: !widget.model.isDone!
          ? Container(
              width: 60,
              height: 34,
              padding: const EdgeInsets.symmetric(
                vertical: 7,
                horizontal: 12,
              ),
              decoration: const BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const ImageIcon(
                color: Colors.white,
                AssetImage(
                  AppAssets.doneIcon,
                ),
              ),
            )
          : Text(
              'Done!',
              style: LightAppStyles.appBar.copyWith(
                color: Colors.green,
              ),
            ),
    );
  }

  Container buildListTileLeading() {
    return Container(
      width: 4,
      decoration: BoxDecoration(
        color: widget.model.isDone! ? Colors.green : AppColors.blue,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }

  Future<void> deleteTodo() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(TodoDM.collectionName);
    DocumentReference documentReference =
        collectionReference.doc(widget.model.id);
    await documentReference.delete();
  }

  Future<void> update() async {
    TodoDM model = TodoDM(
      description: widget.model.description,
      title: widget.model.title,
      id: widget.model.id,
      dateTime: widget.model.dateTime,
      isDone: widget.model.isDone,
    );
    await FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(TodoDM.collectionName)
        .doc(widget.model.id)
        .update(model.toJson());
  }
}
