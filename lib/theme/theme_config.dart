import 'package:flutter/material.dart';
import 'package:flutter_learning_project/page/theme_extension_test.dart';

class ThemeConfig {
  static final ThemeData _themeData1 = ThemeData(
    useMaterial3: false,
      primarySwatch: Colors.deepOrange,
      textTheme:
          const TextTheme(bodyMedium: TextStyle(color: Colors.deepOrange)),
      cardColor: Colors.deepOrange,
      extensions: [ColorExtension(Colors.deepOrange)]);

  static final ThemeData _themeData2 = ThemeData(
      useMaterial3: false,
      primarySwatch: Colors.blue,
      textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.blue)),
      cardColor: Colors.blue,
      extensions: [ColorExtension(Colors.blue)]);

  static final ThemeData _themeData3 = ThemeData(
      useMaterial3: false,
      primarySwatch: Colors.green,
      textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.green)),
      cardColor: Colors.green,
      extensions: [ColorExtension(Colors.green)]);

  static final ThemeData _themeData4 = ThemeData(
      useMaterial3: false,
      primarySwatch: Colors.pink,
      textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.pink)),
      cardColor: Colors.pink,
      extensions: [ColorExtension(Colors.pink)]);

  static final ThemeData _themeData5 = ThemeData(
      useMaterial3: false,
      primarySwatch: Colors.amber,
      textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.amber)),
      cardColor: Colors.amber,
      extensions: [ColorExtension(Colors.amber)]);

  static final ThemeData _themeData6 = ThemeData(
      useMaterial3: false,
      primarySwatch: Colors.purple,
      textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.purple)),
      cardColor: Colors.purple,
      extensions: [ColorExtension(Colors.purple)]);

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
