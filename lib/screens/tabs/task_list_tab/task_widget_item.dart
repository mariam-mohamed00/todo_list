import 'package:app_todo_list/model/task.dart';
import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/providers/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ignore: must_be_immutable
class TaskWidgetItem extends StatelessWidget {
   TaskWidgetItem({super.key, required this.task});

  Task task;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.24,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
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
                color: MyTheme.primaryLight,
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
                      task.title ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: MyTheme.primaryLight),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(task.description ?? '',
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                ],
              )),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: MyTheme.primaryLight,
                ),
                child: Icon(
                  Icons.check,
                  color: MyTheme.whiteColor,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
