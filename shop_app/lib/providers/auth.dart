import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/exceptions/auth_exception.dart';
import 'package:shop_app/models/auth_mode.dart';

class Auth with ChangeNotifier {
  late String? _token;
  late DateTime _expiryDate = DateTime.now();
  late String _userId;

  String get userId => _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate.isAfter(DateTime.now()) && _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, AuthMode mode) async {
    try {
      final response =
          await http.post(mode == AuthMode.signup ? signUpUrl : loginUrl,
              body: json.encode({
                'email': email,
                'password': password,
                'returnSecureToken': true,
              }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw AuthException(responseData['error']['message']);
      } else {
        _token = responseData['idToken'];
        _userId = responseData['localId'];
        _expiryDate = DateTime.now().add(
          Duration(
            seconds: int.parse(responseData['expiresIn']),
          ),
        );
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, AuthMode.signup);
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, AuthMode.login);
  }

  Uri get signUpUrl =>
      Uri.parse(kFirebaseSignUpEndpoint + dotenv.env['FB_API_KEY']!);
  Uri get loginUrl =>
      Uri.parse(kFirebaseLoginEndpoint + dotenv.env['FB_API_KEY']!);
}
