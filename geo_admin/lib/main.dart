// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'viewcontroller.dart';

SharedPreferences? sharedPreferences;

Color mainColor = Color.fromARGB(255, 35, 70, 140);
Color itRed = Color.fromRGBO(206, 43, 55, 1);
Color itGrey = Color.fromARGB(255, 236, 238, 240);

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent.withOpacity(0),
      systemNavigationBarColor: itGrey,
      systemNavigationBarDividerColor: itGrey,
      systemNavigationBarContrastEnforced: true,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MrsGeologyAdmin());
}

class MrsGeologyAdmin extends StatelessWidget {
  const MrsGeologyAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(),
      locale: Locale('ar'),
      debugShowCheckedModeBanner: false,
      home: ViewController(),
    );
  }
}
