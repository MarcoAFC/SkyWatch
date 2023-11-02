import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skywatch/app/core/errors/failure.dart';
import 'package:skywatch/app/modules/weather/domain/usecases/get_weather.dart';
import 'package:skywatch/app/modules/weather/presentation/weather/pages/bloc/weather_event.dart';
import 'package:skywatch/app/modules/weather/presentation/weather/pages/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._usecase) : super(WeatherLoadingState()) {
    on<GetWeatherEvent>(
      (event, emit) => _getWeather(lat: event.lat, lon: event.lon, emit: emit),
    );
  }

  final GetWeather _usecase;

  Future<void> _getWeather(
      {required String lat,
      required String lon,
      required Emitter<WeatherState> emit}) async {
    try {
      emit(WeatherLoadingState());
      var response = await _usecase(lat: lat, lon: lon);
      emit(WeatherSuccessState(weather: response));
    } on Failure catch (e) {
      emit(WeatherFailureState(failure: e));
    } catch (e) {
      emit(WeatherFailureState(
          failure: Failure(message: "An error has occurred.")));
    }
  }
}
