
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skywatch/app/modules/weather/data/datasources/remote_weather_datasource.dart';
import 'package:skywatch/app/modules/weather/domain/entities/forecast.dart';
import 'package:skywatch/app/modules/weather/domain/entities/weather.dart';

void main(){
  // these tests should be improved when responses stop being mocked
  RemoteWeatherDatasource datasource = RemoteWeatherDatasource(dio: Dio());
  var lat = "";
  var lon = "";
  group("Remote weather datasource tests", () {
    test("getForecast returns valid response", () async {
      var response = await datasource.getForecast(lat: lat, lon: lon);

      expect(response, isA<List<Forecast>>());
      expect(response.length, 3);
    });

    test("getWeather returns valid response", () async {
      var response = await datasource.getWeather(lat: lat, lon: lon);

      expect(response, isA<Weather>());
      expect(response.temperature, 30);
    });
  });
}