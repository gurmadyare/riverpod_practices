import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedItemController extends StateNotifier<int> {
  SelectedItemController() : super(0);

  void update(int index) {
    state = index;
  }
}


