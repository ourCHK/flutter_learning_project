import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAsyncNotify extends AsyncNotifier<String> {

  @override
  FutureOr<String> build() async{
    print("CustomAsyncNotify build!");
    ref.onDispose(() {
      print("CustomAsyncNotify onDispose");
    });
    return "";
  }

  Future<void> changeValue(String value) async {
    state = const AsyncValue.loading();
    try {
      await Future.delayed(const Duration(seconds: 3));
      state = AsyncValue.data(value);
    } catch (e,stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }



}