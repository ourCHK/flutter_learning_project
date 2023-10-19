import 'package:flutter/material.dart';

class ThemeConfig {
  static ThemeData themeData1 = ThemeData(
    primarySwatch: Colors.deepOrange,
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.deepOrange)),
    cardColor: Colors.deepOrange,
  );

  static ThemeData themeData2 = ThemeData(
    primarySwatch: Colors.blue,
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.blue)),
    cardColor: Colors.blue,
  );

  static ThemeData themeData3 = ThemeData(
    primarySwatch: Colors.green,
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.green)),
    cardColor: Colors.green,
  );

  static ThemeData themeData4 = ThemeData(
    primarySwatch: Colors.pink,
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.pink)),
    cardColor: Colors.pink,
  );

  static ThemeData themeData5 = ThemeData(
    primarySwatch: Colors.amber,
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.amber)),
    cardColor: Colors.amber,
  );

  static ThemeData themeData6 = ThemeData(
    primarySwatch: Colors.purple,
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.purple)),
    cardColor: Colors.purple,
  );

  static List<ThemeData> themeList = [
    themeData1,
    themeData2,
    themeData3,
    themeData4,
    themeData5,
    themeData6,
  ];
}
