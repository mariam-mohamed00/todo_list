import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/providers/app_config_provider.dart';
import 'package:app_todo_list/screens/tabs/task_list_tab/add_task_bottom_sheet.dart';
import 'package:app_todo_list/screens/tabs/task_list_tab/task_list_tab_screen.dart';
import 'package:app_todo_list/screens/tabs/setting_tab/setting_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [TaskListTabScreen(), SettingTabScreen()];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context)!.to_do_list,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: provider.appTheme == ThemeMode.light? MyTheme.whiteColor : MyTheme.blackDark,
        notchMargin: 8,
        child: BottomNavigationBar(
            currentIndex: index,
            elevation: 0,
            onTap: (value) {
              index = value;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: 'Task List'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Setting'),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
             backgroundColor: provider.appTheme == ThemeMode.light ? MyTheme.whiteColor : MyTheme.backgroundDark,
            context: context, builder: (context) => AddTaskBottomSheet(),);
        },
        child: Icon(
          Icons.add,
          size: 34,
          color: MyTheme.whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[index],
    );
  }
}
