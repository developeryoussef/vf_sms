// To parse this JSON data, do
//
//     final messageRoom = messageRoomFromJson(jsonString);

import 'dart:convert';

MessageRoom messageRoomFromJson(String str) => MessageRoom.fromJson(json.decode(str));

String messageRoomToJson(MessageRoom data) => json.encode(data.toJson());

class MessageRoom {
    MessageRoom({
    required    this.isChatAcive,
     required   this.id,
     required   this.roomId,
     required   this.roomName,
     required   this.messages,
     required   this.v,
    });

    bool isChatAcive;
    String id;
    String roomId;
    String roomName;
    List<Message> messages;
    int v;

    factory MessageRoom.fromJson(Map<String, dynamic> json) => MessageRoom(
        isChatAcive: json["isChatAcive"],
        id: json["_id"],
        roomId: json["roomId"],
        roomName: json["roomName"],
        messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "isChatAcive": isChatAcive,
        "_id": id,
        "roomId": roomId,
        "roomName": roomName,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "__v": v,
    };
}

class Message {
    Message({
       required this.time,
      required  this.id,
     required   this.message,
     required   this.userId,
    });

    DateTime time;
    String id;
    String message;
    String userId;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        time: DateTime.parse(json["time"]),
        id: json["_id"],
        message: json["message"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "time": time.toIso8601String(),
        "_id": id,
        "message": message,
        "userId": userId,
    };
}
