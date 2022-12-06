import 'package:flutter/material.dart';

import '../services/weather.dart';
import '../utilities/constants.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final dynamic locationWeather;

  const LocationScreen({super.key, required this.locationWeather});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  late int temperature;
  late String cityName;
  late String weatherIcon;
  late String weatherMessage;

  WeatherModel weatherModel = WeatherModel();
  @override
  void initState() {
    super.initState();
    print(widget.locationWeather);
    updateUI(locationWeather: widget.locationWeather);
  }

  void updateUI({dynamic locationWeather}) {
    double temp = locationWeather['main']['temp'];
    int condition = locationWeather['weather'][0]['id'];
    setState(() {
      temperature = temp.toInt();
      cityName = locationWeather['name'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMessage = weatherModel.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      final locationWeather =
                          await weatherModel.getLocationWeather();
                      updateUI(locationWeather: locationWeather);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      String? enteredCityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CityScreen(),
                        ),
                      );
                      if (enteredCityName != null &&
                          enteredCityName.isNotEmpty) {
                        updateUI(
                          locationWeather: await weatherModel.getCityWeather(
                            cityName: enteredCityName,
                          ),
                        );
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName!',
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
