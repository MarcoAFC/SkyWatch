import 'package:dio/dio.dart';
import 'package:skywatch/app/core/errors/failure.dart';
import 'package:skywatch/app/modules/weather/data/adapters/forecast_adapter.dart';
import 'package:skywatch/app/modules/weather/data/adapters/weather_adapter.dart';
import 'package:skywatch/app/modules/weather/domain/entities/forecast.dart';
import 'package:skywatch/app/modules/weather/domain/entities/weather.dart';
import 'package:skywatch/app/modules/weather/infra/datasources/weather_datasource.dart';

class RemoteWeatherDatasource implements WeatherDatasource {
  final Dio dio;

  RemoteWeatherDatasource({required this.dio});

  @override
  Future<List<Forecast>> getForecast(
      {required String lat, required String lon}) async {
    try {
      // TODO: uncomment when api is ready
      // final response = await dio.get('/forecast');
      final response = Response(
          requestOptions: RequestOptions(path: "/forecast"),
          statusCode: 200,
          data: {"data": forecastData});
      if (response.statusCode != 200) {
        throw Failure(
            message: response.statusMessage ??
                "Our server might be unavailable at the moment, please try again later.");
      }
      return response.data?['data']
              ?.map((e) => ForecastAdapter.fromJson(e))
              .toList() ??
          [];
    } on DioException catch (e, stackTrace) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Failure(
            message: "Please check your connection.", stackTrace: stackTrace);
      }
      throw Failure(
          message: "An unexpected connection error has ocurred.",
          stackTrace: stackTrace);
    }
  }

  @override
  Future<Weather> getWeather({required String lat, required String lon}) async {
    try {
      // TODO: uncomment when api is ready
      // final response = await dio.get('/weather');
      final response = Response(
          requestOptions: RequestOptions(path: "/weather"),
          statusCode: 200,
          data: {"data": weatherData});
      if (response.statusCode != 200) {
        throw Failure(
            message: response.statusMessage ??
                "Our server might be unavailable at the moment, please try again later.");
      }
      return WeatherAdapter.fromJson((response.data?['data'])!);
    } on DioException catch (e, stackTrace) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Failure(
            message: "Please check your connection.", stackTrace: stackTrace);
      }
      throw Failure(
          message: "An unexpected connection error has ocurred.",
          stackTrace: stackTrace);
    }
  }
}

const weatherData = <String, dynamic>{
  "weather_conditions": "Sunny",
  "id": 1,
  "description": "Clear sky",
  "icon": "sunny_icon",
  "temperature": 30
};

const forecastData = [
  {
    "max_temperature": 30,
    "min_temperature": 20,
    "weather_conditions": "Sunny",
    "id": 1,
    "description": "Clear sky",
    "icon": "sunny_icon"
  },
  {
    "max_temperature": 25,
    "min_temperature": 18,
    "weather_conditions": "Partly Cloudy",
    "id": 2,
    "description": "Partly cloudy sky",
    "icon": "partly_cloudy_icon"
  },
  {
    "max_temperature": 28,
    "min_temperature": 22,
    "weather_conditions": "Rainy",
    "id": 3,
    "description": "Light rain showers",
    "icon": "rainy_icon"
  }
];
