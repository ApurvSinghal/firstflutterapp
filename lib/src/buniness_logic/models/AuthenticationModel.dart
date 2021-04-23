// To parse this JSON data, do
//
//     final authenticationModel = authenticationModelFromJson(jsonString);

import 'dart:convert';

AuthenticationModel authenticationModelFromJson(String str) =>
    AuthenticationModel.fromJson(json.decode(str));

String authenticationModelToJson(AuthenticationModel data) =>
    json.encode(data.toJson());

class AuthenticationModel {
  AuthenticationModel({
    this.strategy,
    this.email,
    this.password,
  });

  final String strategy;
  final String email;
  final String password;

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) =>
      AuthenticationModel(
        strategy: json["strategy"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "strategy": strategy,
        "email": email,
        "password": password,
      };
}
