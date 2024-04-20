import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/ex-2/state_notifier.dart';

//provider
final counterProvider =
    StateNotifierProvider<Counter, int?>((ref) => Counter());

class StateNotifierCounter extends ConsumerWidget {
  const StateNotifierCounter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("Whole widget rebuilded!");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        toolbarHeight: 100,
        title: const Text("StateNotifierProvider"),
        centerTitle: true,
      ),
      body: Center(child: Consumer(builder: (context, ref, child) {
        //counter
        final counter = ref.watch(counterProvider);

        return Text(
          "$counter",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        );
      })),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10, bottom: 20),
        child: FloatingActionButton(
          onPressed: () {
            ref.read(counterProvider.notifier).increment();
          },
          shape: const CircleBorder(),
          backgroundColor: Colors.orange,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
