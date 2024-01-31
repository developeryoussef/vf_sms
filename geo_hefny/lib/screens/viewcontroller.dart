// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, avoid_unnecessary_containers, library_private_types_in_public_api, unused_field, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geo_hefny/screens/auth_and_profile/profile_screen.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../configs/themes/light_theme.dart';
import '../main.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'home/quiz_home_screen.dart';
import 'home/sessions_screen.dart';
import 'home/settings_screen.dart';

class ViewController extends StatefulWidget {
  static const String routeName = '/homescreen';

  @override
  _ViewControllerState createState() => _ViewControllerState();
}

class _ViewControllerState extends State<ViewController> {
  int currentindex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ProfileScreen(),
    ScreenSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: seconderyColor,
      body: _widgetOptions[currentindex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            child: GNav(
              rippleColor: Colors.grey.shade300,
              hoverColor: Colors.grey[300]!,
              gap: 17.5,
              activeColor: Colors.black,
              iconSize: 23,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              duration: Duration(milliseconds: 600),
              tabBackgroundColor: mainColor,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: ' الرئيسية ',
                  textColor: currentindex == 0 ? Colors.white : Colors.black,
                  iconActiveColor:
                      currentindex == 0 ? Colors.white : Colors.black,
                ),
                GButton(
                  icon: LineIcons.history,
                  text: 'نتائجي',
                  textColor: currentindex == 1 ? Colors.white : Colors.black,
                  iconActiveColor:
                      currentindex == 1 ? Colors.white : Colors.black,
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'الاعدادات',
                  textColor: currentindex == 2 ? Colors.white : Colors.black,
                  iconActiveColor:
                      currentindex == 2 ? Colors.white : Colors.black,
                ),
              ],
              selectedIndex: currentindex,
              onTabChange: (index) {
                setState(() {
                  currentindex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
