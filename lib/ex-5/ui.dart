import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/ex-5/data_model.dart';
import 'package:riverpod_practice/ex-5/person.dart';
import 'package:riverpod_practice/widgets/my_font.dart';

final peopleProvider = ChangeNotifierProvider((ref) => PersonModel());

//controllers
final nameController = TextEditingController();
final ageController = TextEditingController();

//
Future<Person?> createOrUpdatePersonDialog(
  BuildContext context, [
  Person? existingPerson,
]) {
  String? name = existingPerson?.name;
  int? age = existingPerson?.age;

  nameController.text = name ?? '';
  ageController.text = age.toString() ?? '';

  return showDialog<Person?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const MyFont(text: "Create a person"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //name
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Enter name here...",
                ),
                onChanged: (value) => name = value,
              ),
              //age
              TextField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: "Enter age here...",
                ),
                onChanged: (value) => age = int.tryParse(value),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const MyFont(text: "Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (name != null && age != null) {
                  if (existingPerson != null) {
                    //have an existing person, update only
                    final newPerson = existingPerson.updated(name, age);

                    Navigator.of(context).pop(newPerson);
                  } else {
                    //no existing person, create a new one
                    Navigator.of(context).pop(
                      Person(name: name!, age: age!),
                    );
                  }
                } else {
                  //no nothing, just exit
                  Navigator.of(context).pop();
                }
              },
              child: const MyFont(text: "Save"),
            ),
          ],
        );
      });
}

class PersonUI extends ConsumerWidget {
  const PersonUI({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        toolbarHeight: 100,
        title: const Text("Person"),
        centerTitle: true,
      ),
      body: Consumer(builder: (context, ref, child) {
        //lets grab our data model
        final personModel = ref.watch(peopleProvider);
        return ListView.builder(
          itemCount: personModel.count,
          itemBuilder: (context, index) {
            final person = personModel.people[index];

            return ListTile(
              title: GestureDetector(
                onTap: () async {
                  final updatedPerson = await createOrUpdatePersonDialog(
                    context,
                    person,
                  );

                  if (updatedPerson != null) {
                    personModel.update(updatedPerson);
                  }
                },
                child: MyFont(text: person.displayName),
              ),
            );
          },
        );
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 10),
        child: FloatingActionButton(
          backgroundColor: Colors.orange,
          shape: const CircleBorder(),
          onPressed: () async {
            final person = await createOrUpdatePersonDialog(context);

            if (person != null) {
              final personModel = ref.read(peopleProvider);

              personModel.add(person);
            }
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
