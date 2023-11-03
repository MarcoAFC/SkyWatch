import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skywatch/app/core/errors/failure.dart';
import 'package:skywatch/app/modules/weather/data/adapters/forecast_adapter.dart';
import 'package:skywatch/app/modules/weather/data/adapters/weather_adapter.dart';
import 'package:skywatch/app/modules/weather/domain/entities/forecast.dart';
import 'package:skywatch/app/modules/weather/domain/entities/weather.dart';
import 'package:skywatch/app/modules/weather/infra/datasources/weather_datasource.dart';
import 'package:skywatch/app/modules/weather/infra/repositories/weather_repository_impl.dart';

class MockWeatherDatasource extends Mock implements WeatherDatasource {}

void main() {
  WeatherDatasource datasource = MockWeatherDatasource();
  WeatherRepositoryImpl repository =
      WeatherRepositoryImpl(datasource: datasource);
  var weather = WeatherAdapter.fromJson({
    "weather_conditions": "Sunny",
    "id": 1,
    "description": "Clear sky",
    "icon": "10d",
    "temperature": 30
  });

  var forecast = ForecastAdapter.fromJson({
    "max_temperature": 30,
    "min_temperature": 20,
    "weather_conditions": "Sunny",
    "id": 1,
    "description": "Clear sky",
    "icon": "10d",
    "day": "11/11"
  });
  group("Weather repository tests", () {
    test("Weather repository get weather returns valid response", () async {
      when(() => datasource.getWeather(lat: 'lat', lon: 'lon'))
          .thenAnswer((invocation) async => weather);
      var response = await repository.getWeather(lat: 'lat', lon: 'lon');
      expect(response, isA<Weather>());
    });

    test("Weather repository get weather rethrows failure", () async {
      when(() => datasource.getWeather(lat: 'lat', lon: 'lon'))
          .thenThrow(Failure(message: 'An unexpected error has ocurred, please try again later'));
      try {
        await repository.getWeather(lat: 'lat', lon: 'lon');
      } on Failure catch (e) {
        expect(e, isA<Failure>());
        expect(e.message, "An unexpected error has ocurred, please try again later");
      }
    });

    test("Weather repository get Forecast returns valid response", () async {
      when(() => datasource.getForecast(lat: 'lat', lon: 'lon'))
          .thenAnswer((invocation) async => [forecast]);
      var response = await repository.getForecast(lat: 'lat', lon: 'lon');
      expect(response, isA<List<Forecast>>());
    });

    test("Weather repository get Forecast rethrows failure", () async {
      when(() => datasource.getForecast(lat: 'lat', lon: 'lon'))
          .thenThrow(Failure(message: 'An unexpected error has ocurred, please try again later'));
      try {
        await repository.getForecast(lat: 'lat', lon: 'lon');
      } on Failure catch (e) {
        expect(e, isA<Failure>());
        expect(e.message, "An unexpected error has ocurred, please try again later");
      }
    });
  });
}
