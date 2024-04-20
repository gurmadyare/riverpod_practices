import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedColorController extends StateNotifier<Color> {
  SelectedColorController() : super(Colors.white);

  void updateColor() {
    state = Colors.amber;
  }
}
