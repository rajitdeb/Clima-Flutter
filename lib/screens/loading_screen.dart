import 'dart:developer';

import 'package:clima_app_flutter/model/network.dart';
import 'package:clima_app_flutter/screens/location_screen.dart';
import 'package:flutter/material.dart';
import '../model/location.dart';
import '../model/location_weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longtitude;

  void getUserLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude!;
    longtitude = location.longitude!;

    log("User Location: Lat: ${location.latitude}, Long: ${location.longitude}");

    NetworkHelper networkHelper = NetworkHelper(
      latitude: latitude!,
      longitude: longtitude!,
    );

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

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(
          data: LocationWeatherData(
            temp,
            weatherCondID,
            cityName,
          ),
        ),
      ),
    );
  }

  /// THERE ARE 3 PRIMARY STATES OF A WIDGET
  /// 1. initState() => Called when widget is initialized
  /// 2. build() => called on every recomposition
  /// 3. deActivate() => called when widget is destroyed
  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
