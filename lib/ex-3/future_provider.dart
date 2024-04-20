import 'package:flutter_riverpod/flutter_riverpod.dart';

enum City {
  stockholm,
  paris,
  mogadishu,
}

const unknownWeatherEmoji = '🤷‍♂️';

typedef WeatherEmoji = String;

Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(
    const Duration(seconds: 1),
    () => {
      City.stockholm: '☃️',
      City.paris: '🌤️',
      City.mogadishu: '☔',
    }[City]!,
  );
}

//state provider (will be changed by the UI)
final currentCityProvider = StateProvider<City?>((ref) => null);
