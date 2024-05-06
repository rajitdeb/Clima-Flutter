class LocationWeatherData {
  final double temperature;
  final int weatherCondition;
  final int aqi;
  final String cityName;
  final String lat;
  final String long;

  LocationWeatherData(
    this.temperature,
    this.weatherCondition,
    this.aqi,
    this.cityName,
    this.lat,
    this.long,
  );
}
