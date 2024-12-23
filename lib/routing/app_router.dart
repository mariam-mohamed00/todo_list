import 'package:app_todo_list/auth/login/login_screen.dart';
import 'package:app_todo_list/auth/register/register_screen.dart';
import 'package:app_todo_list/routing/routes.dart';
import 'package:app_todo_list/screens/tabs/task_list_tab/edit_task_screen.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
            builder: (context) => const HomeScreen(), settings: settings);
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (context) => const LoginScreen(), settings: settings);
      case Routes.registerScreen:
        return MaterialPageRoute(
            builder: (context) => const RegisterScreen(), settings: settings);
      case Routes.editTaskScreen:
        return MaterialPageRoute(
            builder: (context) => const EditTaskScreen(), settings: settings);

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(),
        );
    }
  }
}
