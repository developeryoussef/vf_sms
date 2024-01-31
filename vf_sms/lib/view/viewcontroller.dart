import '../../main.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import 'package:line_icons/line_icons.dart';
import '../controllers/home_controller.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, avoid_unnecessary_containers, library_private_types_in_public_api, unused_field, use_key_in_widget_constructors

class ViewController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor,
            surfaceTintColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              controller.currentIndex == 0 ? 'Messages' : 'Profile',
              style: GoogleFonts.mPlusRounded1c(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: controller.screensList[controller.currentIndex!],
          backgroundColor: Colors.grey.shade200,
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: secondryColor,
              currentIndex: controller.currentIndex!,
              unselectedItemColor: mainColor,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.w900),
              onTap: (value) {
                controller.navToScreen(value);
              },
              items: [
                BottomNavigationBarItem(
                    label: 'Home',
                    icon: Icon(
                      LineIcons.home,
                      color: mainColor,
                    )),
                BottomNavigationBarItem(
                    label: 'Profile',
                    icon: Icon(
                      LineIcons.user,
                      color: mainColor,
                    )),
              ]),
        );
      },
    );
  }
}
