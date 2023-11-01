import 'package:skywatch/app/modules/weather/domain/entities/weather.dart';

class WeatherAdapter{
  static Weather fromJson(Map<String, dynamic> json) {
    return Weather(
      weatherConditions: json['weather_conditions'],
      id: json['id'],
      description: json['description'],
      icon: json['icon'],
      temperature: json['temperature'],
    );
  }
}