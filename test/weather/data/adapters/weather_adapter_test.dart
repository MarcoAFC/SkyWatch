import 'package:flutter_test/flutter_test.dart';
import 'package:skywatch/app/modules/weather/data/adapters/weather_adapter.dart';
import 'package:skywatch/app/modules/weather/domain/entities/weather.dart';

void main() {
  var json = {
    "weather_conditions": "Sunny",
    "id": 1,
    "description": "Clear sky",
    "icon": "10d",
    "temperature": 30
  };
  group("Weather adapter tests", () {
    test("Weather adapter correctly parses json", () async {
      var response = WeatherAdapter.fromJson(json);
      expect(response, isA<Weather>());
      expect(response.temperature, 30);
      expect(response.weatherConditions, "Sunny");
      expect(response.id, 1);
      expect(response.description, "Clear sky");
      expect(response.icon, "10d");
    });
  });
}
