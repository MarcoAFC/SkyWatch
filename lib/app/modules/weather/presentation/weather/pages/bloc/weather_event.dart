abstract interface class WeatherEvent{}

class GetWeatherEvent implements WeatherEvent{
  final String lat;
  final String lon;

  GetWeatherEvent({required this.lat, required this.lon});

}