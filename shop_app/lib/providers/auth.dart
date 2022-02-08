import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/exceptions/auth_exception.dart';
import 'package:shop_app/models/auth_mode.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime _expiryDate = DateTime.now();
  String _userId = '';
  Timer? _authTimer;

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
        _autoLogout();
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

  void logout() {
    _token = null;
    _userId = '';
    _expiryDate = DateTime.now();
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer?.cancel();
    }
    final timeToExpiration = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiration), logout);
  }

  Uri get signUpUrl =>
      Uri.parse(kFirebaseSignUpEndpoint + dotenv.env['FB_API_KEY']!);
  Uri get loginUrl =>
      Uri.parse(kFirebaseLoginEndpoint + dotenv.env['FB_API_KEY']!);
}
