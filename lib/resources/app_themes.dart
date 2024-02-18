import 'package:flutter/material.dart';

class MyThemeData {
  static const Color DarkPrimary = Color(0xff06004F);
  static ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xff183555),
    textTheme:   const TextTheme(
      headlineSmall: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff183555),fontFamily:"poppinsRegular"),
      titleMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff183555)),
      bodyMedium: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w400, color: Color(0xff183555)),
        displayMedium: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xff183555)),


    ),
    scaffoldBackgroundColor:Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedIconTheme: IconThemeData(size: 32),
      selectedItemColor:  Color(0xff06004F),
    ),

  iconTheme: const IconThemeData(
    color: Color(0xff06004F),
  ),

  );
}
