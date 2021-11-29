import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
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

  void getData() {
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {'lat':,'lon':,'appid':'2120877fdf66e2a6e72b20118df6eb9e'});
    http
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(15),
        color: Colors.red,
      ),
    );
  }
}
