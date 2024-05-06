import 'package:flutter/material.dart';

const kCityBackgroundImagePath = "images/city_background.jpg";
const kLocationBackgroundImagePath = "images/location_background.jpg";

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kConditionTextStyle = TextStyle(fontSize: 100.0);

const kAQITextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 25.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 50.0,
);

const kCityInputFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: "Enter City Name",
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
);

const kApiBaseUrl = "https://api.openweathermap.org/data/2.5/weather";
const kAirQualityApiBaseUrl =
    "https://api.openweathermap.org/data/2.5/air_pollution";
const kAppID = "YOUR_APP_ID";
