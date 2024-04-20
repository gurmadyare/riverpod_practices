
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//provider
final currentDateProvider = Provider<DateTime>((ref) => DateTime.now());

final class Ex1 extends ConsumerWidget {
  const Ex1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     //ref.watch(yourProvider) -> watches your provider's value if it changes 
    //it rebuilds the entire comsumer widget and updates the new value to the app.

    final date = ref.watch(currentDateProvider);
 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        toolbarHeight: 100,
        title: const Text("Home page"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "$date",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
