import 'package:skywatch/app/core/errors/failure.dart';
import 'package:skywatch/app/modules/weather/domain/repositories/weather_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skywatch/app/modules/weather/data/adapters/weather_adapter.dart';
import 'package:skywatch/app/modules/weather/domain/entities/weather.dart';
import 'package:skywatch/app/modules/weather/domain/usecases/get_weather.dart';



class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  WeatherRepository repository = MockWeatherRepository();
  GetWeather usecase =
      GetWeather(repository: repository);
  var weather = WeatherAdapter.fromJson({
    "weather_conditions": "Sunny",
    "id": 1,
    "description": "Clear sky",
    "icon": "10d",
    "temperature": 30
  });
  group("Get forecast usecase tests", () {
    test("get weather returns valid response", () async {
      when(() => repository.getWeather(lat: 'lat', lon: 'lon'))
          .thenAnswer((invocation) async => weather);
      var response = await usecase(lat: 'lat', lon: 'lon');
      expect(response, isA<Weather>());
    });

    test("get weather rethrows failure", () async {
      when(() => repository.getWeather(lat: 'lat', lon: 'lon'))
          .thenThrow(Failure(message: 'An unexpected error has ocurred, please try again later'));
      try {
        await usecase(lat: 'lat', lon: 'lon');
      } on Failure catch (e) {
        expect(e, isA<Failure>());
        expect(e.message, "An unexpected error has ocurred, please try again later");
      }
    });

    test("get weather throws when lat/lan is empty", () async {
    
      try {
        await usecase(lat: '', lon: '');
      } on Failure catch (e) {
        expect(e, isA<Failure>());
        expect(e.message, "Invalid coordinates were sent, please try a different set.");
      }
    });
  });
}
