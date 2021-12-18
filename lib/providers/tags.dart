import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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

  void addOrRemove(dynamic tag) {
    bool elementIsInTheList = lisContainsTag(tag);
    if (elementIsInTheList) {
      _selectedTags.removeWhere((element) => element['id'] == tag['id']);
    } else {
      _selectedTags.add(tag);
    }
  }

  List<dynamic> get selectedTags {
    return _selectedTags;
  }

  void clearSelectedTag() {
    _selectedTags = [];
  }

  bool lisContainsTag(Map<String, dynamic> tag) {
    bool isInList = false;
    _selectedTags.forEach((element) {
      if (mapEquals(element, tag)) {
        isInList = true;
      }
    });
    return isInList;
  }
}
