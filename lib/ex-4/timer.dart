import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/ex-4/stream_provider.dart';

class MyOwnTimer extends ConsumerWidget {
  const MyOwnTimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          toolbarHeight: 100,
          title: const Text("Timer"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              //padding top
              const SizedBox(height: 30),

              //
              names.when(
                data: (names) {
                  return ListView.builder(
                      itemCount: names.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(names.elementAt(index)),
                        );
                      });
                },
                error: (error, stackTrace) =>
                    const Text("Reached the end of the list!, 🤔"),
                loading: () => const CircularProgressIndicator(),
              ),
            ],
          ),
        ));
  }
}
