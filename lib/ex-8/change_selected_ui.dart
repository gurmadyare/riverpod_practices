import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/ex-8/selected_item_controller.dart';
import 'package:riverpod_practice/widgets/my_font.dart';

import 'selected_color_controller.dart';

//providers
final selectedItemProvider = StateNotifierProvider<SelectedItemController, int>(
  (ref) => SelectedItemController(),
);

final selectedColorProvider =
    StateNotifierProvider<SelectedColorController, Color>(
  (ref) => SelectedColorController(),
);

class ChangeSelectedUI extends ConsumerWidget {
  const ChangeSelectedUI({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("Whole widget rebuilded");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const MyFont(
            text: "Change selected item color",
            size: 20,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          toolbarHeight: 100,
        ),
        body: Center(
          child: Wrap(
            spacing: 10,
            children: List.generate(
              5,
              (index) => InkWell(
                onTap: () {
                  ref.read(selectedItemProvider.notifier).update(index);
                  ref.read(selectedColorProvider.notifier).updateColor();
                },
                child: Consumer(
                  builder: (context, ref, child) {
                    final itemIndex = ref.watch(selectedItemProvider);
                    final currItemColor = ref.watch(selectedColorProvider);

                    print("Only container widget rebuilded");
                    return Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color:
                            itemIndex != index ? Colors.white : currItemColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: MyFont(
                        text: "${itemIndex == index ? itemIndex : 0}",
                        color: Colors.black,
                        size: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
