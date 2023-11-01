import 'package:skywatch/app/modules/weather/domain/entities/forecast.dart';

class ForecastAdapter {
  static Forecast fromJson(Map<String, dynamic> json) {
    return Forecast(
      maxTemperature: json['max_temperature'],
      minTemperature: json['min_temperature'],
      weatherConditions: json['weather_conditions'],
      id: json['id'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}
