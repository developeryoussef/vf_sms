import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../view/screens/surahs-screen.dart';
import 'package:sapili/view/screens/homepage.dart';
import '../view/screens/azkar-categories-screen.dart';
// ignore_for_file: unused_import, prefer_const_constructors



class NavigationController extends GetxController {
  int currentindex = 1;
  final screensList = [
    SurahsPage(),
    HomePage(),
    AzkarCategoriesScreen(),
  ];

  navToScreen(int index) {
    currentindex = index;
    update();
  }
}
