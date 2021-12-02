import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    Networking networking = Networking(
      url: Uri.https(
        'api.openweathermap.org',
        '/data/2.5/weather',
        {
          'lat': '${location.latitude}',
          'lon': '${location.longitude}',
          'mode': 'json',
          'units': 'metric',
          'appid': dotenv.env['OPENWEATHER_API_KEY'],
        },
      ),
    );
    return await networking.getData();
  }

  Future<dynamic> getCityWeather(String cityName) async {
    Networking networking = Networking(
      url: Uri.https(
        'api.openweathermap.org',
        '/data/2.5/weather',
        {
          'q': '$cityName',
          'mode': 'json',
          'units': 'metric',
          'appid': dotenv.env['OPENWEATHER_API_KEY'],
        },
      ),
    );
    return await networking.getData();
  }

  static String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  static String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
