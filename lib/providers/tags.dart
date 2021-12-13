import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Tags with ChangeNotifier {
  List<dynamic> _allTags = [];
  List<dynamic> _selectedTags = [];

  List<dynamic> get allTags {
    return _allTags;
  }

  Future<List<dynamic>> fetchTags() async {
    var url = Uri.parse('http://10.0.2.2:3000/v1/tags');
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    _allTags = jsonDecode(response.body);

    return _allTags;
  }
}
