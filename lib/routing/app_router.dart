import 'package:app_todo_list/routing/routes.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
            builder: (context) => const HomeScreen(), settings: settings);
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(),
        );
    }
  }
}
