import 'package:geolocator/geolocator.dart';

class Location {
  late double longitude;
  late double latitude;

  Future<void> getCurrentLocation() async {
    try {
      //! You will have to explicitly ask the user for permission to use the Location Service.
      LocationPermission locationPermission =
          await Geolocator.requestPermission();

      if (locationPermission == LocationPermission.whileInUse ||
          locationPermission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);
        longitude = position.longitude;
        latitude = position.latitude;
      }
    } catch (e) {
      print(e);
    }
  }
}
