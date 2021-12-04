import 'dart:convert';

import 'package:cook_app/models/http_exception.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

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
    } catch (error) {
      rethrow;
    }
  }
}
