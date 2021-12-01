import 'dart:async';
import 'dart:convert';

import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location location = Location();

  dynamic weatherData;

  void getLocationData() async {
    await location.getCurrentLocation();

    Networking networking = Networking(
      url: Uri.https(
        'api.openweathermap.org',
        '/data/2.5/weather',
        {
          'lat': '${location.latitude}',
          'lon': '${location.longitude}',
          'mode': 'json',
          'appid': dotenv.env['OPENWEATHER_API_KEY'],
        },
      ),
    );
    weatherData = await networking.getData();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
