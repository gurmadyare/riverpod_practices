import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/my_font.dart';
import 'fruits_screen.dart';

class FruitsHomeScreen extends StatelessWidget {
  const FruitsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const MyFont(text: "Home Screen", size: 18),
        leading: const Icon(Icons.arrow_back),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const MyFont(text: "List of fruits", size: 24),
          const SizedBox(height: 30),
          Expanded(child: Consumer(
            builder: (context, ref, child) {
              //Let's watch the provider here..
              final fruits = ref.watch(fruitsProvider);
              return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: fruits.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: MyFont(text: fruits[index]),
                  );
                },
              );
            },
          )),

          //go to fruits screen
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const FruitsScreen();
              }));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(horizontal: 45),
            ),
            child: const MyFont(text: "Go to fruits screen"),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
