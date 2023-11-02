import 'package:skywatch/app/core/errors/failure.dart';
import 'package:skywatch/app/modules/weather/domain/entities/weather.dart';

abstract interface class WeatherState {}

class WeatherSuccessState extends WeatherState{
  final Weather weather;

  WeatherSuccessState({required this.weather});
}

class WeatherFailureState extends WeatherState{
  final Failure failure;

  WeatherFailureState({required this.failure});
}

class WeatherLoadingState extends WeatherState{}
