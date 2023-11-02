import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skywatch/app/core/errors/failure.dart';
import 'package:skywatch/app/modules/weather/domain/usecases/get_forecast.dart';
import 'package:skywatch/app/modules/weather/presentation/forecast/pages/bloc/forecast_event.dart';
import 'package:skywatch/app/modules/weather/presentation/forecast/pages/bloc/forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  ForecastBloc(this._usecase) : super(ForecastLoadingState()) {
    on<GetForecastEvent>(
      (event, emit) => _getForecast(lat: event.lat, lon: event.lon, emit: emit),
    );
  }

  final GetForecast _usecase;

  Future<void> _getForecast(
      {required String lat,
      required String lon,
      required Emitter<ForecastState> emit}) async {
    try {
      emit(ForecastLoadingState());
      var response = await _usecase(lat: lat, lon: lon);
      emit(ForecastSuccessState(forecast: response));
    } on Failure catch (e) {
      emit(ForecastFailureState(failure: e));
    } catch (e) {
      emit(ForecastFailureState(
          failure: Failure(message: "An error has occurred.")));
    }
  }
}
