import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/location.dart';

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
    getWeatherData();
    return const Scaffold();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.longitude);
    print(location.latitude);
  }

  void getWeatherData() async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=60d17fd4fec338a835ad9d77b1c6ddb4'),
    );
    if (response.statusCode == 200) {
      print(response.body);
      final data = jsonDecode(response.body);
      String cityName = data['name'];
      double temp = data['main']['temp'];
      int condition = data['weather'][0]['id'];
      print(cityName);
      print(temp);
      print(condition);
    } else {
      print(response.statusCode);
    }
  }
}
