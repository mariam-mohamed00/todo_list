import 'package:flutter/material.dart';

class MyTheme{
  static Color primaryLight = Color(0xff5D9CEC);
  static Color backgroundLight = Color(0xffDFECDB);
  static Color greenColor = Color(0xff61E757);
  static Color redColor = Color(0xffEC4B4B);
  static Color blackColor = Color(0xff383838);
  static Color whiteColor = Color(0xffffffff);
  static Color greyColor = Color(0xffC8C9CB);
  static Color backgoundDark = Color(0xff060E1E);
  static Color blackDark = Color(0xff141922);

  static ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryLight,
      toolbarHeight: 200,
      elevation: 0
    ),

    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: whiteColor)
    )
  );
}