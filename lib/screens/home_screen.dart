import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/providers/app_config_provider.dart';
import 'package:app_todo_list/providers/auth_provider.dart';
import 'package:app_todo_list/routing/routes.dart';
import 'package:app_todo_list/screens/tabs/task_list_tab/add_task_bottom_sheet.dart';
import 'package:app_todo_list/screens/tabs/task_list_tab/task_list_tab_screen.dart';
import 'package:app_todo_list/screens/tabs/setting_tab/setting_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [const TaskListTabScreen(), const SettingTabScreen()];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<UserAuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                // listProvider.tasksList = [];
                // authProvider.currentuser = null;
                Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
              },
              icon: Icon(
                Icons.logout,
                color: MyTheme.whiteColor,
              ))
        ],
        title: Text(
          (index == 0
              ? '${AppLocalizations.of(context)!.to_do_list}'
                  ' ${authProvider.currentuser!.name}'
              : '${AppLocalizations.of(context)!.settings}'
                  ' ${authProvider.currentuser!.name}'),

          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: provider.appTheme == ThemeMode.light
            ? MyTheme.whiteColor
            : MyTheme.blackDark,
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
            backgroundColor: provider.appTheme == ThemeMode.light
                ? MyTheme.whiteColor
                : MyTheme.backgroundDark,
            context: context,
            builder: (context) => const AddTaskBottomSheet(),
          );
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
