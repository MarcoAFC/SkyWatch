import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:skywatch/app/modules/weather/data/datasources/remote_weather_datasource.dart';
import 'package:skywatch/app/modules/weather/domain/repositories/weather_repository.dart';
import 'package:skywatch/app/modules/weather/domain/usecases/get_forecast.dart';
import 'package:skywatch/app/modules/weather/domain/usecases/get_weather.dart';
import 'package:skywatch/app/modules/weather/infra/datasources/weather_datasource.dart';
import 'package:skywatch/app/modules/weather/infra/repositories/weather_repository_impl.dart';
import 'package:skywatch/app/modules/weather/presentation/forecast/pages/bloc/forecast_bloc.dart';
import 'package:skywatch/app/modules/weather/presentation/weather/pages/bloc/weather_bloc.dart';

class DependencyHandler{
  static final DependencyHandler _instance = DependencyHandler._internal();

  factory DependencyHandler() {
    return _instance;
  }
  
  DependencyHandler._internal() {
    registerDependencies();
  }


  final GetIt di = GetIt.I;

  void registerDependencies(){
    di.registerLazySingleton<Dio>(() => Dio());

    di.registerLazySingleton<WeatherDatasource>(() => RemoteWeatherDatasource(dio: di.get()));
    di.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(datasource: di.get()));
    di.registerLazySingleton<GetWeather>(() => GetWeather(repository: di.get()));
    di.registerLazySingleton<GetForecast>(() => GetForecast(repository: di.get()));
    di.registerLazySingleton<WeatherBloc>(() => WeatherBloc(di.get()));
    di.registerLazySingleton<ForecastBloc>(() => ForecastBloc(di.get()));
  }

  T get<T extends Object>(){
    return di.get<T>(); 
  }
}