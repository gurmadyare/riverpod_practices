import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumberNotifier extends StateNotifier<List<String>> {
  NumberNotifier() : super(["Number 12", "Number 30"]);

  //methods
  void add(String number) {
    state = [...state, number];
  }

  void remove(String number) {
    state = [...state.where((element) => element != number)];
  }

  void update(String number, String updatedNumber) {
    final updatedList = <String>[];
    for (int i = 0; i < state.length; i++) {
      if (state[i] == number) {
        updatedList.add(updatedNumber);
      } else {
        updatedList.add(state[i]);
      }
    }

    state = updatedList;
  }
}
