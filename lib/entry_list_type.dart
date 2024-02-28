import 'package:flutter/material.dart';
import 'package:flutter_learning_project/page/custom_check_box.dart';
import 'package:flutter_learning_project/page/custom_paint_page.dart';
import 'package:flutter_learning_project/page/custom_provider_page.dart';
import 'package:flutter_learning_project/page/custom_scroll_view_page.dart';
import 'package:flutter_learning_project/page/custom_touch_event_page.dart';
import 'package:flutter_learning_project/page/error_riverpod_page.dart';
import 'package:flutter_learning_project/page/flutter_toast_page.dart';
import 'package:flutter_learning_project/page/go_router_page.dart';
import 'package:flutter_learning_project/page/inherited_widget_page.dart';
import 'package:flutter_learning_project/page/lifecycle_test_page.dart';
import 'package:flutter_learning_project/page/localization_page.dart';
import 'package:flutter_learning_project/page/login_test_page.dart';
import 'package:flutter_learning_project/page/notification_page.dart';
import 'package:flutter_learning_project/page/riverpod_test_page.dart';
import 'package:flutter_learning_project/page/theme_change_page.dart';
import 'package:flutter_learning_project/page/theme_extension_test.dart';
import 'package:flutter_learning_project/page/touch_event_page.dart';
import 'package:flutter_learning_sub_project/page/sub_page.dart';
import 'package:go_router/go_router.dart';

enum EntryListType {
  themeExtensionTest,
  lifeCycleTest,
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
  riverpodPage,
  errorRiverpodPage,
  toastPage,
  customScrollViewPage
}

extension EntryListTypeExtension on EntryListType {
  Widget getPageWidget(BuildContext context, GoRouterState goRouterState) {
    switch (this) {
      case EntryListType.themeExtensionTest:
        return const ThemeExtensionPage();
      case EntryListType.lifeCycleTest:
        return const LifecycleTestPage();
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
      case EntryListType.errorRiverpodPage:
        return ErrorRiverpodParentPage();
      case EntryListType.toastPage:
        return FlutterToastPage();
      case EntryListType.customScrollViewPage:
        return const CustomScrollViewPage();
    }
  }
}
