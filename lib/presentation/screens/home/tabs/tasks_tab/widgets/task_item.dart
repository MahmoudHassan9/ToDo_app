import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/core/utils/app_assets.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/light_app_styles.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/tasks_tab.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.model,
    required this.onDelete,
  });

  final TodoDM model;
  final Function onDelete;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  GlobalKey<TasksTabState> tasksTabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
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
                deleteTodo();
                widget.onDelete();
              },
              backgroundColor: AppColors.red,
              foregroundColor: AppColors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) {},
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
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: buildListTileLeading(),
            title: Text(
              widget.model.title!,
              style: LightAppStyles.poppinsFontWeight700Size18,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              widget.model.description!,
              style: LightAppStyles.taskItemDesc,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            trailing: buildListTileTrailing(),
          ),
        ),
      ),
    );
  }

  Container buildListTileTrailing() {
    return Container(
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
    );
  }

  Container buildListTileLeading() {
    return Container(
      width: 4,
      decoration: const BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.all(
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
}
