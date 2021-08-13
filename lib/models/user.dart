
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User(
      {required this.points,
      required this.id,
      required this.firebaseId,
      required this.name,
      required this.credit});

  dynamic points;
  String id;
  String firebaseId;
  String name;
  dynamic credit;
  factory User.fromJson(Map<String, dynamic> json) => User(
        points: json["points"],
        id: json["_id"],
        firebaseId: json["firebaseId"],
        name: json["name"],
        credit: json["credit"],
      );

  Map<String, dynamic> toJson() => {
        "points": points,
        "_id": id,
        "firebaseId": firebaseId,
        "name": name,
        "credit": credit
      };
}
