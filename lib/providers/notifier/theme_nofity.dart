import 'package:flutter/material.dart';
import 'package:flutter_learning_project/theme/theme_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotify extends Notifier<ThemeData> {

  @override
  ThemeData build() {
    return ThemeConfig.themeList[0];
  }

  void changeTheme(ThemeData themeData) {
    state = themeData;
  }

}