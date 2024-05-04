import 'dart:convert';
import 'dart:developer';

import 'package:clima_app_flutter/util/constants.dart';
import 'package:http/http.dart';

class NetworkHelper {
  final double latitude;
  final double longitude;

  NetworkHelper({required this.latitude, required this.longitude});

  Future getWeatherData() async {
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
