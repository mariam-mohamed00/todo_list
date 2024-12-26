// ignore_for_file: avoid_print

import 'package:app_todo_list/model/task.dart';
import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/providers/app_config_provider.dart';
import 'package:app_todo_list/providers/auth_provider.dart';
import 'package:app_todo_list/providers/list_provider.dart';
import 'package:app_todo_list/routing/routes.dart';
import 'package:app_todo_list/utils/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class TaskWidgetItem extends StatefulWidget {
  TaskWidgetItem({super.key, required this.task});

  Task task;

  @override
  State<TaskWidgetItem> createState() => _TaskWidgetItemState();
}

class _TaskWidgetItemState extends State<TaskWidgetItem> {
  late UserAuthProvider userAuthProvider;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    var listProvider = Provider.of<ListProvider>(context);

    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(Routes.editTaskScreen, arguments: widget.task);
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.24,
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  userAuthProvider =
                      Provider.of<UserAuthProvider>(context, listen: false);

                  FirebaseUtils.deleteTaskFromFireStore(
                          widget.task, userAuthProvider.currentuser?.id ?? '')
                      .timeout(
                    const Duration(microseconds: 500),
                    onTimeout: () {
                      print('task was deleted');
                      print('---------------------------------------');
                      listProvider.getAllTasksFromFireStore(
                          userAuthProvider.currentuser?.id ?? '');
                    },
                  );
                },
                backgroundColor: MyTheme.redColor,
                foregroundColor: MyTheme.whiteColor,
                icon: Icons.delete,
                label: AppLocalizations.of(context)!.delete,
                spacing: 12,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: provider.appTheme == ThemeMode.light
                    ? MyTheme.whiteColor
                    : MyTheme.blackDark),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: widget.task.isDone!
                      ? MyTheme.greenColor
                      : MyTheme.primaryLight,
                  height: MediaQuery.of(context).size.height * 0.09,
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.task.title ?? '',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: widget.task.isDone!
                                ? MyTheme.greenColor
                                : MyTheme.primaryLight),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.task.description ?? '',
                          style: Theme.of(context).textTheme.titleSmall),
                    ),
                  ],
                )),
                InkWell(
                  onTap: () {
                    userAuthProvider =
                        Provider.of<UserAuthProvider>(context, listen: false);
                    FirebaseUtils.editIsDone(
                        widget.task, userAuthProvider.currentuser?.id ?? '');
                  },
                  child: widget.task.isDone!
                      ? Text(
                          AppLocalizations.of(context)!.done,
                          style: TextStyle(
                              color: MyTheme.greenColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: MyTheme.primaryLight,
                          ),
                          child: Icon(
                            Icons.check,
                            color: MyTheme.whiteColor,
                            size: 30,
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
