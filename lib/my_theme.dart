import 'package:flutter/material.dart';

class MyTheme{
  static Color primaryLight = const Color(0xff5D9CEC);
  static Color backgroundLight = const Color(0xffDFECDB);
  static Color greenColor = const Color(0xff61E757);
  static Color redColor = const Color(0xffEC4B4B);
  static Color blackColor = const Color(0xff383838);
  static Color whiteColor = const Color(0xffffffff);
  static Color greyColor = const Color(0xffC8C9CB);
  static Color backgroundDark = const Color(0xff060E1E);
  static Color blackDark = const Color(0xff141922);

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
      titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: blackColor),
      titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: blackColor),
    )
  );

  static ThemeData darkMode = ThemeData(
      scaffoldBackgroundColor: backgroundDark,
      appBarTheme: AppBarTheme(
          backgroundColor: primaryLight,
          toolbarHeight: 100,
          elevation: 0
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: MyTheme.primaryLight,
        elevation: 0,
        shape: StadiumBorder(side: BorderSide(color: MyTheme.blackDark, width: 5)),

      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.transparent,
        selectedIconTheme: IconThemeData(color: primaryLight, size: 26),
        unselectedIconTheme: IconThemeData(color: whiteColor, size: 26),
        elevation: 0,
        selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: blackColor),
        unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: blackColor),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: blackColor),
        titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: whiteColor),
        titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: whiteColor),
      )
  );

}