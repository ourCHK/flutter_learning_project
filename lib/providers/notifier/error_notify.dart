import 'package:flutter/material.dart';
import 'package:flutter_learning_project/theme/theme_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorNotify extends Notifier<String> {

  @override
  String build() {
    return "old value!";
  }

  void changeValue(String newValue) {
    state = newValue;
  }
}