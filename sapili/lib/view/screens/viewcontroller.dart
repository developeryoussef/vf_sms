// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, avoid_unnecessary_containers, library_private_types_in_public_api, unused_field, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sapili/constant/colors.dart';
import 'package:sapili/controller/navigationcontroller.dart';

import '../../main.dart';
import 'homepage.dart';
import 'surahs-screen.dart';

class ViewController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (controller) {
        return Scaffold(
          body: controller.screensList[controller.currentindex],
          backgroundColor: Colors.grey.shade200,
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: secondColor,
              currentIndex: controller.currentindex,
              unselectedItemColor: mainColor,
              selectedLabelStyle: TextStyle(
                  fontFamily: 'ArbFONTS', fontWeight: FontWeight.w900),
              unselectedLabelStyle: TextStyle(
                fontFamily: 'ArbFONTS',
              ),
              onTap: (value) {
                controller.navToScreen(value);
              },
              items: [
                BottomNavigationBarItem(
                    label: 'القرآن',
                    icon: Icon(
                      LineIcons.quran,
                      color: mainColor,
                    )),
                BottomNavigationBarItem(
                    label: 'الرئيسية',
                    icon: Icon(
                      LineIcons.home,
                      color: mainColor,
                    )),
                BottomNavigationBarItem(
                    label: 'الاذكار',
                    icon: Icon(
                      LineIcons.hands,
                      color: mainColor,
                    )),
              ]),
        );
      },
    );
  }
}
