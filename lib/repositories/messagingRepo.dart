import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rewayat_alkateb_islam/constants.dart';
import 'package:rewayat_alkateb_islam/models/messageRoom.dart';

class MessagingRepo {
  getAllMessages() async {
    late MessageRoom messageRoom;
    Response response = await Dio().get(
        "$baseUrl/messaging/${FirebaseAuth.instance.currentUser!.uid}admin");
    if (response.statusCode == 200) {
      messageRoom = MessageRoom.fromJson(response.data);
      return messageRoom;
    } else {
      return false;
    }
  }

  addMessage(message) async {
    Response response = await Dio().post(
        "$baseUrl/messaging/${FirebaseAuth.instance.currentUser!.uid}admin",
        data: {
          "senderId": FirebaseAuth.instance.currentUser!.uid,
          "messageText": message
        });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
