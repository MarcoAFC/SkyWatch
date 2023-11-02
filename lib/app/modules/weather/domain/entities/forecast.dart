class Forecast{
  final num maxTemperature;
  final num minTemperature;
  final String weatherConditions;
  final int id;
  final String description;
  final String icon;
  final String day;

  Forecast({required this.day,required this.maxTemperature, required this.minTemperature, required this.weatherConditions, required this.id, required this.description, required this.icon});
}