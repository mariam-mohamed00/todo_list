import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/screens/tabs/task_list_tab/task_widget_item.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

class TaskListTabScreen extends StatelessWidget {
  const TaskListTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) => print(date),
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
              return const TaskWidgetItem();
            },
          ),
        )
      ],
    );
  }
}
