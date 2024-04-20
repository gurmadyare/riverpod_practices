import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter extends StateNotifier<int?> {
  //by default value = null
  Counter() : super(null);

  void increment() {
    state = state == null ? 1 : (state ?? 0) + 1;
  }
}
