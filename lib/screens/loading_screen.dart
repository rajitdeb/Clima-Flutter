import 'package:clima_app_flutter/model/weather.dart';
import 'package:clima_app_flutter/screens/location_screen.dart';
import 'package:flutter/material.dart';
import '../model/location_weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getUserLocation() async {
    LocationWeatherData dataToPass =
        await Weather().getWeatherDataFromLocation();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(
          data: dataToPass,
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
