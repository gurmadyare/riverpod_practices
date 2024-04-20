import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/crud/notifier.dart';
import 'package:riverpod_practice/widgets/my_font.dart';

//provider
final numbersProvider = StateNotifierProvider<NumberNotifier, List<String>>(
  (ref) => NumberNotifier(),
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const MyFont(text: "CRUD PRACTICE"),
        centerTitle: true,
        toolbarHeight: 100,
      ),
      body: Consumer(builder: (context, ref, child) {
        final numbers = ref.watch(numbersProvider);
        return Center(
          child: SingleChildScrollView(
            child: Column(
              children: numbers
                  .map((e) => GestureDetector(
                        onTap: () {
                          ref.read(numbersProvider.notifier).remove(e);
                        },
                        onLongPress: () {
                          ref
                              .read(numbersProvider.notifier)
                              .update(e, "Number ${Random().nextInt(100)}");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyFont(text: e, size: 18, color: Colors.green),
                        ),
                      ))
                  .toList(),
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          final rnNo = Random().nextInt(100);

          ref.read(numbersProvider.notifier).add("Number $rnNo");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
