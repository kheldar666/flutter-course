import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '/constants.dart';
import '/exceptions/auth_exception.dart';
import '/models/auth_mode.dart';

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
        final preferences = await SharedPreferences.getInstance();
        final userData = {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
        };
        preferences.setString('userData', json.encode(userData));
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

  Future<bool> tryAutoLogin() async {
    final preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey('userData')) {
      return false;
    }
    final userData =
        json.decode(preferences.getString('userData')!) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(userData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = userData['token'];
    _userId = userData['userId'];
    _expiryDate = expiryDate;
    _autoLogout();
    notifyListeners();
    return true;
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
