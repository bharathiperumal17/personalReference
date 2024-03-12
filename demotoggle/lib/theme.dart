import 'package:flutter/material.dart';

class ThemeDataClass {
  static final darkTheme = ThemeData(
    // buttonTheme: const ButtonThemeData(buttonColor: Colors.greenAccent),//not working
    // buttonTheme: ButtonThemeData(
    //     colorScheme: ColorScheme.dark(
    //   background: Colors.grey.shade600,
    //   primary: Colors.blue.shade900,
    // )),//not working

    // floatingActionButtonTheme:const FloatingActionButtonThemeData(backgroundColor: Colors.greenAccent),
    // elevatedButtonTheme: const ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.greenAccent))),
    scaffoldBackgroundColor: Colors.grey.shade800,
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade600,
      onPrimaryContainer: Colors.blue.shade900,
    ),
  );

  static final lightTheme = ThemeData(
      // buttonTheme: const ButtonThemeData(buttonColor: Colors.orange),
    //    buttonTheme: ButtonThemeData(
    //     colorScheme: ColorScheme.dark(
    //   background: Colors.grey.shade600,
    //   primary: Colors.blue.shade900,
    // )),//not working
      // floatingActionButtonTheme:const FloatingActionButtonThemeData(backgroundColor: Colors.orangeAccent),
      //  elevatedButtonTheme: const ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.orangeAccent))),
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(
        background: Colors.white70,
        onPrimaryContainer: Colors.black,
      ));
}
