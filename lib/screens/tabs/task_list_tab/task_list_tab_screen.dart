import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/providers/auth_provider.dart';
import 'package:app_todo_list/providers/list_provider.dart';
import 'package:app_todo_list/screens/tabs/task_list_tab/task_widget_item.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskListTabScreen extends StatefulWidget {
  const TaskListTabScreen({super.key});

  @override
  State<TaskListTabScreen> createState() => _TaskListTabScreenState();
}

class _TaskListTabScreenState extends State<TaskListTabScreen> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var userAuthProvider = Provider.of<UserAuthProvider>(context);
    listProvider
        .getAllTasksFromFireStore(userAuthProvider.currentuser?.id ?? '');
    return Column(
      children: [
        CalendarTimeline(
          initialDate: listProvider.selectDate,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) {
            listProvider.changeSelectedDate(
                date, userAuthProvider.currentuser?.id ?? '');
          },
          leftMargin: 20,
          monthColor: MyTheme.blackColor,
          dayColor: MyTheme.blackColor,
          activeDayColor: MyTheme.whiteColor,
          activeBackgroundDayColor: MyTheme.primaryLight,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskWidgetItem(task: listProvider.tasksList[index]);
            },
            itemCount: listProvider.tasksList.length,
          ),
        )
      ],
    );
  }
}
