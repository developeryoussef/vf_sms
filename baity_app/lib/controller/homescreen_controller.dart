import 'package:get/get.dart';
import '../view/screen/home.dart';
import '../view/screen/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../view/screen/notification.dart';
// ignore_for_file: unnecessary_import

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

abstract class HomeScreenController extends GetxController {
  changePage(int currentpage);
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentpage = 0;

  List<Widget> listPage = [
    const HomePage(),
    NotificationView(),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Center(child: Text("Profile"))],
    ),
    Settings()
  ];

  List bottomappbar = [
    {"title": "home", "icon": Icons.home},
    {"title": "n", "icon": Icons.notifications_active_outlined},
    {"title": "profile", "icon": Icons.person_pin_sharp},
    {"title": "settings", "icon": Icons.settings}
  ];

  @override
  changePage(int i) {
    currentpage = i;
    update();
  }
}
