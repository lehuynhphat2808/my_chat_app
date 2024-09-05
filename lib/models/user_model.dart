// To parse this JSON data, do
//
//     final componentModel = componentModelFromJson(jsonString);

import 'dart:convert';

UserModel componentModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String componentModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? uid;
  String? email;
  String? name;

  UserModel({
    this.uid,
    this.email,
    this.name,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        name: name ?? this.name,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
      };
}
