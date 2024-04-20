import 'package:flutter_riverpod/flutter_riverpod.dart';

class FruitsController extends StateNotifier<List<String>> {
  FruitsController() : super(["Apple", "Banana", "Orange", "Mango"]);

  void add(String item) {
    state = [...state, item];
  }

  void remove(String removedItem) {
    state = [
      for (final item in state)
        if (item != removedItem) item
    ];
  }
}
