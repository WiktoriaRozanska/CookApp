import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cook_app/models/user.dart' as model;
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
  final String? authToke;
  model.User _user = model.User(
      email: '',
      createdAt: DateTime.now(),
      id: '',
      isFemale: true,
      username: '');

  User(this.authToke);

  Future<model.User> fetchCurrentUser() async {
    var url = Uri.parse('http://10.0.2.2:3000/v1/me');
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": '${authToke}'
    });
    Map<String, dynamic> userMap = jsonDecode(response.body);
    _user = model.User.fromJson(userMap);
    return _user;
  }

  Future<model.User> updateUser(bool newGender, String newUsername) async {
    var body = {
      'user': {
        'isFemale': newGender,
        'username': newUsername,
      }
    };

    var url = Uri.parse('http://10.0.2.2:3000/v1/users/:id');
    final response = await http.post(url, body: body, headers: {
      "Content-Type": "application/json",
      "Authorization": '${authToke}'
    });
    Map<String, dynamic> userMap = jsonDecode(response.body);
    _user = model.User.fromJson(userMap);
    return _user;
  }
}
