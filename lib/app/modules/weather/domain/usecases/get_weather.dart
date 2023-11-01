import 'package:skywatch/app/core/errors/failure.dart';
import 'package:skywatch/app/modules/weather/domain/entities/weather.dart';
import 'package:skywatch/app/modules/weather/domain/repositories/weather_repository.dart';

class GetWeather{
  final WeatherRepository repository;

  GetWeather({required this.repository});

  Future<Weather> call({required String lat, required String lon}) async {
    if(lat.isEmpty || lon.isEmpty){
      throw Failure(message: "Invalid coordinates were sent, please try a different set.");
    }
    return await repository.getWeather(lat: lat, lon: lon);
  }

}