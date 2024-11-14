import 'package:flutter/material.dart';

class MyTheme{
  static Color primaryLight = Color(0xff5D9CEC);
  static Color backgroundLight = Color(0xffDFECDB);
  static Color greenColor = Color(0xff61E757);
  static Color redColor = Color(0xffEC4B4B);
  static Color blackColor = Color(0xff383838);
  static Color whiteColor = Color(0xffffffff);
  static Color greyColor = Color(0xffC8C9CB);
  static Color backgroundDark = Color(0xff060E1E);
  static Color blackDark = Color(0xff141922);

  static ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryLight,
      toolbarHeight: 100,
      elevation: 0
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: MyTheme.primaryLight,
      elevation: 0,
      shape: StadiumBorder(side: BorderSide(color: MyTheme.whiteColor, width: 5)),

    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.transparent,
      selectedIconTheme: IconThemeData(color: primaryLight, size: 26),
      unselectedIconTheme: IconThemeData(color: greyColor, size: 26),
      elevation: 0,
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: blackColor),
      unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: blackColor),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: whiteColor),
    )
  );
}