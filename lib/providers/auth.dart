import 'dart:convert';

import 'package:cook_app/models/http_exception.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;

  bool get isAuth {
    try {
      if (_token != null) {
        return !JwtDecoder.isExpired(_token!);
      }
    } catch (error) {
      return false;
    }
    return false;
  }

  String? get token {
    return _token;
  }

  Future<void> signup(String email, String nickname, String password,
      String confirmPassword) async {
    var url = Uri.parse('http://10.0.2.2:3000/users');
    try {
      final response = await http.post(url,
          body: json.encode({
            'user': {
              'email': email,
              'password': password,
              'password_confirmation': confirmPassword,
              'username': nickname,
            }
          }),
          headers: {"Content-Type": "application/json"});
      final responseData = json.decode(response.body);

      if (response.statusCode != 201) {
        throw HttpException(responseData['errors']);
      }

      _token = response.headers['authorization'];
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', '${_token}');
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    var url = Uri.parse('http://10.0.2.2:3000/users/sign_in');
    try {
      final response = await http.post(url,
          body: json.encode({
            'user': {
              'email': email,
              'password': password,
            }
          }),
          headers: {"Content-Type": "application/json"});

      final responseData = json.decode(response.body);
      if (response.statusCode != 201) {
        throw HttpException(responseData);
      }

      _token = response.headers['authorization'];
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', '${_token}');
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', 'user decided to log out');
    if (!prefs.containsKey('token')) {
      return false;
    }

    _token = prefs.getString('token');
    if (isAuth) {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    var url = Uri.parse('http://10.0.2.2:3000/users/sign_out');
    try {
      final response = await http.delete(url, headers: {
        "Content-Type": "application/json",
        "Authorization": '${_token}'
      });

      if (response.statusCode <= 300) {
        _token = null;
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', 'user decided to log out');
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
