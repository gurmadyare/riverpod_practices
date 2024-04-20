import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/ex-7/fruits_controller.dart';
import 'package:riverpod_practice/ex-7/home_screen.dart';
import 'package:riverpod_practice/widgets/my_font.dart';

//controllers
TextEditingController addedItemController = TextEditingController();
TextEditingController removedItemController = TextEditingController();

//providers
final fruitsProvider = StateNotifierProvider<FruitsController, List<String>>(
    (ref) => FruitsController());

class FruitsScreen extends ConsumerWidget {
  const FruitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const MyFont(text: "Fruits Screen", size: 18),
        leading: GestureDetector(
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const FruitsHomeScreen();
                })),
            child: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Center(child: MyFont(text: "List of fruits")),
          const SizedBox(height: 30),
          //list of fruits
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

          //add & remove buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: (context),
                    builder: (context) {
                      return MyDialog(
                        title: "Add an Item to the fruits",
                        controller: addedItemController,
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(horizontal: 45)),
                child: const MyFont(text: "Add Item"),
              ),

              //

              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: (context),
                    builder: (context) {
                      return MyDialog(
                        title: "Remove an Item to the fruits",
                        controller: removedItemController,
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: const MyFont(text: "Remove Item"),
              ),
            ],
          ),

          //
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class MyDialog extends ConsumerWidget {
  final String title;
  final TextEditingController controller;
  const MyDialog({super.key, required this.title, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? newItem;
    String? removedItem;
    return AlertDialog(
      title: MyFont(text: title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //item
          TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Enter the item here....",
              ),
              onChanged: (item) => {
                    controller == addedItemController
                        ? newItem = item
                        : removedItem = item
                  }),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            controller == addedItemController
                ? ref.read(fruitsProvider.notifier).add(newItem!)
                : ref.read(fruitsProvider.notifier).remove(removedItem!);

            Navigator.pop(context);
          },
          child: const MyFont(text: "Save"),
        ),
        const SizedBox(width: 100),
        //
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const MyFont(text: "Cancel"),
        ),
      ],
    );
  }
}
