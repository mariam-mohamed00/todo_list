import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/routing/app_router.dart';
import 'package:app_todo_list/routing/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      onGenerateRoute: AppRouter.generateRoute,

      theme: MyTheme.lightMode,
    );
  }
}
