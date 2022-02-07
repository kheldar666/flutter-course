import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;

  Future<void> signup(String email, String password) async {
    final response = await http.post(authUrl,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));

    print(json.decode(response.body));
  }

  Uri get authUrl =>
      Uri.parse(kFirebaseAuthEndpoint + dotenv.env['FB_API_KEY']!);
}
