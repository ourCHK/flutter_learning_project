import 'package:flutter/material.dart';
import 'package:flutter_learning_project/page/custom_check_box.dart';
import 'package:flutter_learning_project/page/custom_paint_page.dart';
import 'package:flutter_learning_project/page/custom_provider_page.dart';
import 'package:flutter_learning_project/page/custom_touch_event_page.dart';
import 'package:flutter_learning_project/page/go_router_page.dart';
import 'package:flutter_learning_project/page/inherited_widget_page.dart';
import 'package:flutter_learning_project/page/localization_page.dart';
import 'package:flutter_learning_project/page/login_test_page.dart';
import 'package:flutter_learning_project/page/notification_page.dart';
import 'package:flutter_learning_project/page/riverpod_test_page.dart';
import 'package:flutter_learning_project/page/theme_change_page.dart';
import 'package:flutter_learning_project/page/touch_event_page.dart';
import 'package:flutter_learning_sub_project/page/sub_page.dart';
import 'package:go_router/go_router.dart';

enum EntryListType {
  inheritedWidgetTest,
  customProviderTest,
  themeChangeTest,
  changeLanguageTest,
  subPage,
  customPaintTest,
  customRenderBox,
  touchEventTest,
  notificationTest,
  customTouchEventTest,
  goRouterPage,
  loginPage,
  riverpodPage
}

extension EntryListTypeExtension on EntryListType {

  Widget getPageWidget(BuildContext context, GoRouterState goRouterState) {
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
      case EntryListType.touchEventTest:
        return const TouchEventPage();
      case EntryListType.notificationTest:
        return const MyNotificationPage();
      case EntryListType.customTouchEventTest:
        return const CustomTouchEventPage();
      case EntryListType.goRouterPage:
        return GoRouterPage(goRouterState: goRouterState);
      case EntryListType.loginPage:
        return LoginPage(goRouterState: goRouterState);
      case EntryListType.riverpodPage:
        return RiverpodTestPage();
    }
  }
}
