import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  Future<void> signup(String email, String nickname, String password,
      String confirmPassword) async {
    var url = Uri.parse('http://10.0.2.2:3000/users');
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
    print(response.headers);
    print(json.decode(response.body));
  }

  Future<void> login(String email, String password) async {
    var url = Uri.parse('http://10.0.2.2:3000/users/sign_in');
    final response = await http.post(url,
        body: json.encode({
          'user': {
            'email': email,
            'password': password,
          }
        }),
        headers: {"Content-Type": "application/json"});
    print(response.headers);
    print(json.decode(response.body));
  }
}
