import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/ex-3/future_provider.dart';

final weatherProvider = FutureProvider<WeatherEmoji>((ref) {
  final city = ref.watch(currentCityProvider);

  if (city != null) {
    return getWeather(city);
  } else {
    return unknownWeatherEmoji;
  }
});

class Weather extends StatelessWidget {
  const Weather({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        toolbarHeight: 100,
        title: const Text("FutureProvider"),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final currentWeather = ref.watch(weatherProvider);

          return Column(
            children: [
              const SizedBox(height: 30),
              //displaying current city weather
              currentWeather.when(
                data: (data) =>
                    Text(data, style: const TextStyle(fontSize: 40)),
                error: (_, __) => const Text(
                  "Error 😢",
                  style: TextStyle(fontSize: 25),
                ),
                loading: () => const CircularProgressIndicator(),
              ),
              const SizedBox(height: 70),

              //selecting city
              Expanded(
                child: ListView.builder(
                    itemCount: City.values.length,
                    itemBuilder: (context, index) {
                      final city = City.values[index];
                      final isSelected = city == ref.watch(currentCityProvider);

                      return ListTile(
                        title: Text(city.toString()),
                        onTap: () {
                          ref.read(currentCityProvider.notifier).state = city;
                        },
                        trailing: isSelected
                            ? const Icon(Icons.check_circle,
                                color: Colors.green)
                            : null,
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
