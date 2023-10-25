import 'package:flutter/material.dart';
import 'package:flutter_learning_project/page/custom_check_box.dart';
import 'package:flutter_learning_project/page/custom_paint_page.dart';
import 'package:flutter_learning_project/page/custom_provider_page.dart';
import 'package:flutter_learning_project/page/inherited_widget_page.dart';
import 'package:flutter_learning_project/page/localization_page.dart';
import 'package:flutter_learning_project/page/theme_change_page.dart';
import 'package:flutter_learning_sub_project/page/sub_page.dart';

enum EntryListType {
  inheritedWidgetTest,
  customProviderTest,
  themeChangeTest,
  changeLanguageTest,
  subPage,
  customPaintTest,
  customRenderBox
}

extension EntryListTypeExtension on EntryListType {
  String get pageName {
    return name;
  }

  Widget get pageWidget {
    switch (this) {
      case EntryListType.inheritedWidgetTest:
        return const InheritedWidgetPage();
      case EntryListType.customProviderTest:
        return const CustomProviderPage();
      case EntryListType.themeChangeTest:
        return const ThemeChangePage();
      case EntryListType.changeLanguageTest:
        return const LocalizationPage();
      case EntryListType.subPage:
        return const SubPage();
      case EntryListType.customPaintTest:
        return const CustomPaintPage();
      case EntryListType.customRenderBox:
        return const CustomRenderBoxPage();
    }
  }
}