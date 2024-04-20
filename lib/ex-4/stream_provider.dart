import 'package:flutter_riverpod/flutter_riverpod.dart';

const names = [
  "Alice",
  "Bob",
  "Charlie",
  "David",
  "Eve",
  "Fred",
  "Ginny",
  "Harriet",
  "Ileana",
  "Joseph",
  "Kincaid",
  "Larry",
];

final tickerProvider = StreamProvider<int>(
  (ref) => Stream.periodic(const Duration(seconds: 1), (i) => i + 1),
);

final namesProvider = StreamProvider((ref) {
  final count = ref.watch(tickerProvider.stream);

  return count.map((count) => names.getRange(0, count).toList());
});
