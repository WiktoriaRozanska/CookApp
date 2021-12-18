import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String username;
  String email;
  bool isFemale;
  DateTime createdAt;

  User(
      {required this.id,
      required this.email,
      required this.username,
      required this.createdAt,
      required this.isFemale});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
