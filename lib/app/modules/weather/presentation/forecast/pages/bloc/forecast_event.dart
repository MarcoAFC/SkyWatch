abstract interface class ForecastEvent{}

class GetForecastEvent implements ForecastEvent{
  final String lat;
  final String lon;

  GetForecastEvent({required this.lat, required this.lon});

}