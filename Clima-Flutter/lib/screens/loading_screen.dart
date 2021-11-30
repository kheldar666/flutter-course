import 'dart:convert';

import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print('Longitude: ' + location.longitude.toString());
    print('Latitude: ' + location.latitude.toString());
  }

  void getData() async {
    var url = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {
        'lat': '12',
        'lon': '12',
        'mode': 'json',
        'appid': dotenv.env['OPENWEATHER_API_KEY'],
      },
    );

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      dynamic jsonData = jsonDecode(data);
      double temperature = jsonData['main']['temp'];
      int condition = jsonData['weather'][0]['id'];
      String cityName = jsonData['name'];
      print('temperature => ' + temperature.toString());
      print('condition => ' + condition.toString());
      print('cityName => ' + cityName.toString());
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(15),
        color: Colors.red,
      ),
    );
  }
}
