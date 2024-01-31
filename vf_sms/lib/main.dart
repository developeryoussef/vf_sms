import 'package:get/get.dart';
import 'bindings/init_binding.dart';
import 'package:flutter/material.dart';
import 'view/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: prefer_const_constructors

// ignore_for_file: prefer_typing_uninitialized_variables


SharedPreferences? sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      initialBinding: InitialBindings(),
    );
  }
}
