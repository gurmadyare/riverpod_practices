import 'dart:collection';

import 'package:flutter/material.dart';

import 'person.dart';

class PersonModel extends ChangeNotifier {
  final List<Person> _people = [];

  //no of people
  int get count => _people.length;

  //hey you get the list of people, but you're not allowed to change.
  UnmodifiableListView<Person> get people => UnmodifiableListView(_people);

  //add person
  void add(Person person) {
    _people.add(person);

    notifyListeners();
  }

  //update person
  void update(Person updatedPerson) {
    final index = _people.indexOf(updatedPerson);
    final oldPerson = _people[index];

    if (oldPerson.name != updatedPerson.name ||
        oldPerson.age != updatedPerson.age) {
      _people[index] = oldPerson.updated(
        updatedPerson.name,
        updatedPerson.age,
      );
    }

    notifyListeners();
  }

  //remove person
  void remove(Person person) {
    _people.remove(person);

    notifyListeners();
  }
}
