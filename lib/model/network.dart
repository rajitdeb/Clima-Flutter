import 'dart:convert';
import 'dart:developer';

import 'package:clima_app_flutter/util/constants.dart';
import 'package:http/http.dart';

class NetworkHelper {
  double? latitude;
  double? longitude;

  NetworkHelper({this.latitude, this.longitude});

  Future getWeatherData() async {
    if (latitude != null && longitude != null) {
      Uri uri = Uri.parse(
        "$kApiBaseUrl?lat=$latitude&lon=$longitude&units=metric&appid=$kAppID",
      );

      Response response = await get(uri);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        log(response.statusCode.toString());
      }
    }
  }

  Future getWeatherDataByCityName(String cityName) async {
    Uri uri = Uri.parse(
      "$kApiBaseUrl?q=$cityName&units=metric&appid=$kAppID",
    );

    Response response = await get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      log(response.statusCode.toString());
    }
  }

  Future getAirQualityData(String cityLat, String cityLon) async {
    Uri uri = Uri.parse(
      "$kAirQualityApiBaseUrl?lat=$cityLat&lon=$cityLon&appid=$kAppID",
    );

    Response response = await get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      log(response.statusCode.toString());
    }
  }
}
