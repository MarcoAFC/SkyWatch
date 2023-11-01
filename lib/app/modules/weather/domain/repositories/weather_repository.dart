import 'package:skywatch/app/modules/weather/domain/entities/forecast.dart';
import 'package:skywatch/app/modules/weather/domain/entities/weather.dart';

abstract interface class WeatherRepository{
  Future<Weather> getWeather({required String lat, required String lon});
  Future<List<Forecast>> getForecast({required String lat, required String lon});

}