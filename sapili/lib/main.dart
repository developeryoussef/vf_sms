import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'view/screens/splashscreen.dart';
import 'view/screens/viewcontroller.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore_for_file: unused_import, prefer_const_constructors

SharedPreferences? sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Locale('ar'),
      theme: ThemeData(
          appBarTheme:
              AppBarTheme(titleTextStyle: TextStyle(color: Colors.white))),
      home: ViewController(),
      debugShowCheckedModeBanner: false,
    );
  }
}
