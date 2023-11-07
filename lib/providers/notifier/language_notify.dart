import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageNotify extends Notifier<String> {

  @override
  String build() {
    return "en";
  }

  ///修改语言
  void changeLanguage() {
    if (state == 'en') {
      state = "ar";
    } else {
      state = "en";
    }
  }
}