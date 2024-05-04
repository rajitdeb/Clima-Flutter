import 'dart:developer';

import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<bool> _checkIsLocationPermissionAvailable() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission != LocationPermission.always ||
        permission != LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        return true;
      }
    } else {
      return true;
    }

    return false;
  }

  Future<bool> _checkIsLocationServiceEnabled() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    return isServiceEnabled;
  }

  // Used Future as its an async function
  // Whose value is being observed by another function
  Future<void> getCurrentLocation() async {
    bool isPermissionGranted = await _checkIsLocationPermissionAvailable();

    // Test if location services are enabled
    if (isPermissionGranted) {
      // If Location permission is granted, then check if location services are enabled
      // If both are enabled, get user location
      // Else inform user to allow location permission
      bool isServiceEnabled = await _checkIsLocationServiceEnabled();
      if (isServiceEnabled) {
        Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low,
        );
        latitude = pos.latitude;
        longitude = pos.longitude;
      } else {
        log("Please enable Location Services option from Status Bar!!");
        // Take User to Location Services Page
        await Geolocator.openLocationSettings();
      }
    } else {
      log("Please allow Location permission to use this feature!!");
    }
  }
}
