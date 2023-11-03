import 'package:flutter_test/flutter_test.dart';
import 'package:skywatch/app/modules/weather/data/adapters/forecast_adapter.dart';
import 'package:skywatch/app/modules/weather/domain/entities/forecast.dart';

void main(){
  var json = {
    "max_temperature": 30,
    "min_temperature": 20,
    "weather_conditions": "Sunny",
    "id": 1,
    "description": "Clear sky",
    "icon": "10d",
    "day": "11/11"
  };
  group("Forecast adapter tests", () {
    test("Forecast adapter correctly parses json", () async {
      var response = ForecastAdapter.fromJson(json);
      expect(response, isA<Forecast>());
      expect(response.minTemperature, 20);
      expect(response.maxTemperature, 30);
      expect(response.weatherConditions, "Sunny");
      expect(response.id, 1);
      expect(response.description, "Clear sky");
      expect(response.icon, "10d");
      expect(response.day, "11/11");
    });

  });
}