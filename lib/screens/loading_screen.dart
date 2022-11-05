import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  void getLocation() async {
    try {
      //! You will have to explicitly ask the user for permission to use the Location Service.
      LocationPermission locationPermission =
          await Geolocator.requestPermission();

      if (locationPermission == LocationPermission.whileInUse ||
          locationPermission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);
        print(position);
      }
    } catch (e) {
      print(e);
    }
  }
}
