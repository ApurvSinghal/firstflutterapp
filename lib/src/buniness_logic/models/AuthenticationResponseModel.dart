// To parse this JSON data, do
//
//     final authenticationResponseModel = authenticationResponseModelFromJson(jsonString);

import 'dart:convert';

AuthenticationResponseModel authenticationResponseModelFromJson(String str) =>
    AuthenticationResponseModel.fromJson(json.decode(str));

String authenticationResponseModelToJson(AuthenticationResponseModel data) =>
    json.encode(data.toJson());

class AuthenticationResponseModel {
  AuthenticationResponseModel({
    this.accessToken,
    this.authentication,
    this.user,
  });

  final String accessToken;
  final Authentication authentication;
  final User user;

  factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthenticationResponseModel(
        accessToken: json["accessToken"],
        authentication: Authentication.fromJson(json["authentication"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "authentication": authentication.toJson(),
        "user": user.toJson(),
      };
}

class Authentication {
  Authentication({
    this.strategy,
    this.accessToken,
    this.payload,
  });

  final String strategy;
  final String accessToken;
  final Payload payload;

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
        strategy: json["strategy"],
        accessToken: json["accessToken"],
        payload: Payload.fromJson(json["payload"]),
      );

  Map<String, dynamic> toJson() => {
        "strategy": strategy,
        "accessToken": accessToken,
        "payload": payload.toJson(),
      };
}

class Payload {
  Payload({
    this.iat,
    this.exp,
    this.aud,
    this.iss,
    this.sub,
    this.jti,
  });

  final int iat;
  final int exp;
  final String aud;
  final String iss;
  final String sub;
  final String jti;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        iat: json["iat"],
        exp: json["exp"],
        aud: json["aud"],
        iss: json["iss"],
        sub: json["sub"],
        jti: json["jti"],
      );

  Map<String, dynamic> toJson() => {
        "iat": iat,
        "exp": exp,
        "aud": aud,
        "iss": iss,
        "sub": sub,
        "jti": jti,
      };
}

class User {
  User({
    this.id,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.permissions,
  });

  final String id;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final List<String> permissions;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        email: json["email"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        permissions: List<String>.from(json["permissions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
      };
}
