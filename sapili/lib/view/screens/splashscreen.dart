import 'dart:async';
import 'viewcontroller.dart';
import 'package:get/get.dart';
import '../../constant/colors.dart';
import '../widgets/aladhan-comp.dart';
import 'package:flutter/material.dart';
import '../widgets/last-surah-comp.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../controller/navigationcontroller.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sapili/controller/splashcontroller.dart';

// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, implementation_imports, unnecessary_import, sort_child_properties_last

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Image.asset('assets/Picture1.png'),
              ),
              Text(
                'سبيلي',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ArbFONTS'),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'قُلْ هَٰذِهِ سَبِيلِي أَدْعُو إِلَى اللَّهِ ۚ عَلَىٰ بَصِيرَةٍ أَنَا وَمَنِ اتَّبَعَنِي ۖ وَسُبْحَانَ اللَّهِ وَمَا أَنَا مِنَ الْمُشْرِكِينَ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'me_quran'),
              ),
            ],
          ),
          backgroundColor: mainColor,
        );
      },
    );
  }
}
