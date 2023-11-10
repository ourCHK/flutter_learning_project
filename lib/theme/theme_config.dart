import 'package:flutter/material.dart';

class ThemeConfig {
  static final ThemeData _themeData1 = ThemeData(
    primarySwatch: Colors.deepOrange,
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.deepOrange)),
    cardColor: Colors.deepOrange,
  );

  static final ThemeData _themeData2 = ThemeData(
    primarySwatch: Colors.blue,
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.blue)),
    cardColor: Colors.blue,
  );

  static final ThemeData _themeData3 = ThemeData(
    primarySwatch: Colors.green,
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.green)),
    cardColor: Colors.green,
  );

  static final ThemeData _themeData4 = ThemeData(
    primarySwatch: Colors.pink,
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.pink)),
    cardColor: Colors.pink,
  );

  static final ThemeData _themeData5 = ThemeData(
    primarySwatch: Colors.amber,
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.amber)),
    cardColor: Colors.amber,
  );

  static final ThemeData _themeData6 = ThemeData(
    primarySwatch: Colors.purple,
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.purple)),
    cardColor: Colors.purple,
  );

  static List<ThemeData> themeList = [
    _themeData1,
    _themeData2,
    _themeData3,
    _themeData4,
    _themeData5,
    _themeData6,
  ];

  ///获取主题的位置
  static getThemeIndex(ThemeData themeData) {
    return themeList.indexOf(themeData);
  }
}
