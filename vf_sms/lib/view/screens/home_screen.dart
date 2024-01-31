import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vf_sms/models/message_model.dart';
import 'package:vf_sms/core/constants/colors.dart';
import 'package:vf_sms/core/classes/statusrequest.dart';
import 'package:vf_sms/controllers/home_controller.dart';
// ignore_for_file: avoid_unnecessary_containers

// ignore_for_file: prefer_const_literals_to_create_immutables

// ignore_for_file: unused_import, prefer_const_constructors

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return controller.statusRequest! == StatusRequest.loading
            ? Center(
                child: CircularProgressIndicator(
                  color: secondryColor,
                ),
              )
            : controller.messages.isEmpty == true
                ? Center(
                    child: Text('There is no messages now'),
                  )
                : ListView.builder(
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      print(index);
                      return MessageComponent(
                          messageModel: MessageModel.fromJson(
                              controller.messages[index]));
                    },
                  );
      },
    );
  }
}

class MessageComponent extends StatelessWidget {
  final MessageModel? messageModel;
  const MessageComponent({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 7),
        color: Colors.white,
        child: ListTile(
          title: Row(
            children: [
              Text(
                'sender : ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${messageModel!.messageSender}.".capitalizeFirst.toString(),
                style: TextStyle(color: mainColor),
              ),
            ],
          ),
          subtitle: Text(
            "\n${messageModel!.messageText}".capitalizeFirst.toString(),
            style: TextStyle(
                color: secondryColor,
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
        ));
  }
}
