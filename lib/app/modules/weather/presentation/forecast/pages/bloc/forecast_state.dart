import 'package:skywatch/app/core/errors/failure.dart';
import 'package:skywatch/app/modules/weather/domain/entities/forecast.dart';

abstract interface class ForecastState {}

class ForecastSuccessState extends ForecastState{
  final List<Forecast> forecast;

  ForecastSuccessState({required this.forecast});
}

class ForecastFailureState extends ForecastState{
  final Failure failure;

  ForecastFailureState({required this.failure});
}

class ForecastLoadingState extends ForecastState{}
