import 'package:skywatch/app/core/errors/failure.dart';
import 'package:skywatch/app/modules/weather/domain/entities/forecast.dart';
import 'package:skywatch/app/modules/weather/domain/entities/weather.dart';
import 'package:skywatch/app/modules/weather/domain/repositories/weather_repository.dart';
import 'package:skywatch/app/modules/weather/infra/datasources/weather_datasource.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDatasource datasource;

  WeatherRepositoryImpl({required this.datasource});

  @override
  Future<List<Forecast>> getForecast(
      {required String lat, required String lon}) async {
    try {
      return await datasource.getForecast(lat: lat, lon: lon);
    } on Failure {
      rethrow;
    } catch (error, stackTrace) {
      throw Failure(
          message: 'An unexpected error has ocurred, please try again later',
          stackTrace: stackTrace);
    }
  }

  @override
  Future<Weather> getWeather({required String lat, required String lon}) async {
    try {
      return await datasource.getWeather(lat: lat, lon: lon);
    } on Failure {
      rethrow;
    } catch (error, stackTrace) {
      throw Failure(
          message: 'An unexpected error has ocurred, please try again later',
          stackTrace: stackTrace);
    }
  }
}
