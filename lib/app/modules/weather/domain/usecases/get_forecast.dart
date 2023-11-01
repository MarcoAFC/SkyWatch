import 'package:skywatch/app/core/errors/failure.dart';
import 'package:skywatch/app/modules/weather/domain/entities/forecast.dart';
import 'package:skywatch/app/modules/weather/domain/repositories/weather_repository.dart';

class GetForecast{
  final WeatherRepository repository;

  GetForecast({required this.repository});

  Future<List<Forecast>> call({required String lat, required String lon}) async {
    if(lat.isEmpty || lon.isEmpty){
      throw Failure(message: "Invalid coordinates were sent, please try a different set.");
    }
    return await repository.getForecast(lat: lat, lon: lon);
  }

}