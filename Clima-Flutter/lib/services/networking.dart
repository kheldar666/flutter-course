import 'dart:convert';

import 'package:http/http.dart' as http;

class Networking {
  final Uri url;

  Networking({this.url});

  dynamic getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(
          response.body); //using var or dynamic seems to be the same
    } else {
      print(response.body);
      throw Exception(
          'Error while fetching data from Url. Error Code : ${response.statusCode}');
    }
  }
}
