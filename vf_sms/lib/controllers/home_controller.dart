import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:vf_sms/main.dart';
import '../view/viewcontroller.dart';
import '../core/data/login_data.dart';
import 'package:flutter/material.dart';
import '../core/classes/statusrequest.dart';
import '../view/screens/profile_screen.dart';
import '../core/functions/handling_data.dart';
import 'package:vf_sms/core/classes/crud.dart';
import 'package:vf_sms/core/data/messages_data.dart';
import 'package:vf_sms/view/screens/home_screen.dart';
// ignore_for_file: avoid_print

// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, non_constant_identifier_names

// ignore_for_file: unused_import

class HomeController extends GetxController {
  List<Widget> screensList = [
    HomeScreen(),
    ProfileScreen(),
  ];

  int? currentIndex = 0;
  navToScreen(int index) {
    currentIndex = index;
    update();
  }

  StatusRequest? statusRequest;
  MessagesData messagesData = MessagesData(Get.find());

  List messages = [];

  getMessages() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await messagesData.postdata(
        "${sharedPreferences!.getString('id')}",
        "${sharedPreferences!.getString('apptoken')}");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == true) {
        messages.addAll(response['msgUser']);
        print(messages);
      }
    } else {
      Get.defaultDialog(
          title: "ُWarning", middleText: "Email Or Password Not Correct");
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  @override
  void onInit() {
    getMessages();
    super.onInit();
  }
}
