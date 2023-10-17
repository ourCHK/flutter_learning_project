
import 'package:flutter/material.dart';
import 'package:flutter_learning_project/page/inherited_widget_page.dart';

enum EntryListType {

  inheritedWidgetTest,

}

extension EntryListTypeExtension on EntryListType {

  String get pageName {
    switch(this) {
      case EntryListType.inheritedWidgetTest:
        return "InheritedWidgetTest";
    }
  }

  Widget get pageWidget {
    switch(this) {
      case EntryListType.inheritedWidgetTest:
        return InheritedWidgetPage();
    }
  }

}