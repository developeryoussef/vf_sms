import 'dart:async';
import 'package:get/get.dart';
import 'package:vf_sms/main.dart';
import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import 'package:vf_sms/view/viewcontroller.dart';
import 'package:vf_sms/view/screens/login_screen.dart';
import 'package:vf_sms/controllers/splash_controller.dart';

// ignore_for_file: depend_on_referenced_packages

// ignore_for_file: unused_import, prefer_const_constructors

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () {
        print("nav");
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainLightColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/dark-logo.png',
            ),
          ],
        ),
      ),
    );
  }
}
