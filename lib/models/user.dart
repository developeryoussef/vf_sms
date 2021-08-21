// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';


User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.credit,
    required this.points,
    required this.referredUsers,
    required this.referrerCode,
    required this.id,
    required this.firebaseId,
    required this.name,
    required this.referCode,
    required this.v,
  });

  dynamic credit;
  dynamic points;
  List<String> referredUsers;
  dynamic referrerCode;
  String id;
  String firebaseId;
  String name;
  String referCode;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        credit: json["credit"],
        points: json["points"],
        referredUsers: List<String>.from(json["referredUsers"].map((x) => x)),
        referrerCode: json["referrerCode"]??"",
        id: json["_id"],
        firebaseId: json["firebaseId"],
        name: json["name"],
        referCode: json["referCode"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "credit": credit,
        "points": points,
        "referredUsers":referredUsers,
        "referrerCode": referrerCode,
        "_id": id,
        "firebaseId": firebaseId,
        "name": name,
        "referCode": referCode,
        "__v": v,
      };
}
