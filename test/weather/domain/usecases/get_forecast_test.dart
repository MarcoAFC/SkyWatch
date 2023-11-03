import 'package:skywatch/app/core/errors/failure.dart';
import 'package:skywatch/app/modules/weather/domain/entities/forecast.dart';
import 'package:skywatch/app/modules/weather/domain/repositories/weather_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skywatch/app/modules/weather/data/adapters/forecast_adapter.dart';
import 'package:skywatch/app/modules/weather/domain/usecases/get_forecast.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  WeatherRepository repository = MockWeatherRepository();
  GetForecast usecase = GetForecast(repository: repository);


  var forecast = ForecastAdapter.fromJson({
    "max_temperature": 30,
    "min_temperature": 20,
    "weather_conditions": "Sunny",
    "id": 1,
    "description": "Clear sky",
    "icon": "10d",
    "day": "11/11"
  });
  group("Get forecast usecase tests", () {

    test("get Forecast returns valid response", () async {
      when(() => repository.getForecast(lat: 'lat', lon: 'lon'))
          .thenAnswer((invocation) async => [forecast]);
      var response = await usecase(lat: 'lat', lon: 'lon');
      expect(response, isA<List<Forecast>>());
    });

    test("get Forecast rethrows failure", () async {
      when(() => repository.getForecast(lat: 'lat', lon: 'lon')).thenThrow(
          Failure(
              message:
                  'An unexpected error has ocurred, please try again later'));
      try {
        await usecase(lat: 'lat', lon: 'lon');
      } on Failure catch (e) {
        expect(e, isA<Failure>());
        expect(e.message,
            "An unexpected error has ocurred, please try again later");
      }
    });

    test("get forecast throws when lat/lan is empty", () async {
      try {
        await usecase(lat: '', lon: '');
      } on Failure catch (e) {
        expect(e, isA<Failure>());
        expect(e.message,
            "Invalid coordinates were sent, please try a different set.");
      }
    });
  });
}
