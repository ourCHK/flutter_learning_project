import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListenNotify extends Notifier<int> {

  @override
  int build() {
    return 0;
  }

  void increase(int value) {
    state += value;
  }


}