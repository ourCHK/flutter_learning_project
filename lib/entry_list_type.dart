
import 'package:flutter/material.dart';
import 'package:flutter_learning_project/page/custom_provider_page.dart';
import 'package:flutter_learning_project/page/inherited_widget_page.dart';

enum EntryListType {

  inheritedWidgetTest,
  customProviderTest,

}

extension EntryListTypeExtension on EntryListType {

  String get pageName {
    return name;
  }

  Widget get pageWidget {
    switch(this) {
      case EntryListType.inheritedWidgetTest:
        return const InheritedWidgetPage();
      case EntryListType.customProviderTest:
        return const CustomProviderPage();
    }
  }

}