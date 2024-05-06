import 'dart:developer';

import 'package:clima_app_flutter/model/location_weather.dart';
import 'package:clima_app_flutter/model/weather.dart';
import 'package:clima_app_flutter/screens/city_screen.dart';
import 'package:clima_app_flutter/util/constants.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  final LocationWeatherData data;

  const LocationScreen({super.key, required this.data});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late int temp;
  late int weatherCondition;
  late String cityName;
  String? lat;
  String? long;

  Weather weather = Weather();

  void updateUIForLocation(LocationWeatherData data) async {
    setState(() {
      temp = data.temperature.toInt();
      weatherCondition = data.weatherCondition;
      cityName = data.cityName;

      lat = data.lat;
      long = data.long;
    });
  }

  @override
  void initState() {
    super.initState();
    temp = widget.data.temperature.toInt();
    weatherCondition = widget.data.weatherCondition;
    cityName = widget.data.cityName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(kLocationBackgroundImagePath),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () async {
                      LocationWeatherData data =
                          await weather.getWeatherDataFromLocation();
                      updateUIForLocation(data);
                    },
                    icon: const Icon(
                      Icons.near_me,
                      size: 36.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      var enteredCityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CityScreen(),
                        ),
                      );

                      if (enteredCityName != null) {
                        log("Inputted City Name (in Location Screen): $enteredCityName");
                        var weatherDataByCity =
                            await weather.getWeatherByCityName(enteredCityName);
                        if (weatherDataByCity != null) {
                          updateUIForLocation(weatherDataByCity);
                        }
                      }
                    },
                    icon: const Icon(
                      Icons.location_city,
                      size: 36.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Text(
                      // When we want to access the data of the actual screen
                      // We make use of `widget` object to access that data inside
                      // State Object
                      /// For e.g. For `LocationScreen` class, _LocationScreenState is the state object
                      /// So, to access the data of LocationScreen class inside the _LocationScreenState class
                      /// We have to use the `widget` object
                      "$temp°",
                      style: kTempTextStyle,
                    ),
                    Text(
                      weather.getWeatherIcon(weatherCondition),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "${weather.getMessage(temp)} in $cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
