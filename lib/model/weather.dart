import 'dart:developer';

import 'package:clima_app_flutter/model/location_weather.dart';
import '../model/location.dart';
import '../model/network.dart';

class Weather {
  // Get City Weather
  Future getWeatherByCityName(String enteredCityName) async {
    NetworkHelper helper = NetworkHelper();

    // Gets Raw JSON from API using City Name
    var weatherData = await helper.getWeatherDataByCityName(enteredCityName);

    if (weatherData != null) {
      /// WE'RE USING VAR FOR INDICATING DYNAMIC DATA TYPE
      /// BUT IN PRODUCTION, WE WOULD ALWAYS EXPLICITLY MENTION THE SPECIFIC DATA TYPE
      // Temperature
      var temp = weatherData["main"]["temp"];
      // Weather Condition Number
      var weatherCondID = weatherData["weather"][0]["id"];
      // City Name
      var cityName = weatherData["name"];

      log("Temperature: $temp, Weather Condition: $weatherCondID, City Name: $cityName");

      return LocationWeatherData(temp, weatherCondID, cityName, "0.00", "0.00");
    }
  }

  // Get User Location
  Future<LocationWeatherData> getWeatherDataFromLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    // latitude = location.latitude!;
    // longtitude = location.longitude!;
    //
    log("User Location: Lat: ${location.latitude}, Long: ${location.longitude}");

    NetworkHelper networkHelper = NetworkHelper(
      latitude: location.latitude!,
      longitude: location.longitude!,
    );

    // Gets Raw JSON from API
    var weatherData = await networkHelper.getWeatherData();

    /// WE'RE USING VAR FOR INDICATING DYNAMIC DATA TYPE
    /// BUT IN PRODUCTION, WE WOULD ALWAYS EXPLICITLY MENTION THE SPECIFIC DATA TYPE
    // Temperature
    var temp = weatherData["main"]["temp"];
    // Weather Condition Number
    var weatherCondID = weatherData["weather"][0]["id"];
    // City Name
    var cityName = weatherData["name"];

    log("Temperature: $temp, Weather Condition: $weatherCondID, City Name: $cityName");

    return LocationWeatherData(
      temp,
      weatherCondID,
      cityName,
      location.latitude.toString(),
      location.longitude.toString(),
    );
  }

  // Utility function to get weather icon based on weather condition
  String getWeatherIcon(int condition) {
    if (condition < 300) return "🌩";
    if (condition < 400) return "🌧";
    if (condition < 600) return "☔️";
    if (condition < 700) return "☃️";
    if (condition < 800) return "🌫";
    if (condition == 800) return "☀️";
    if (condition <= 804) return "☁️";
    return "🤷‍";
  }

  // Utility function to get message based on temperature
  String getMessage(int temp) {
    if (temp > 25) return "It's 🍦 time";
    if (temp > 20) return "Time for shorts and 👕";
    if (temp < 10) return "You'll need 🧣 and 🧤";
    return "Bring a 🧥 just in case";
  }
}
