// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  int? id;
  String? username;
  String? email;
  String? password;
  String? gender;
  String? address;
  String? birthdate;
  String? age;

  Users({
    this.id,
    this.username,
    this.email,
    this.password,
    this.gender,
    this.address,
    this.birthdate,
    this.age,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        gender: json["gender"],
        address: json["address"],
        birthdate: json["birthdate"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "gender": gender,
        "address": address,
        "birthdate": birthdate,
        "age": age,
      };
}