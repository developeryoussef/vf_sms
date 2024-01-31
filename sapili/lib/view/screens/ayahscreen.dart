// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, implementation_imports, unnecessary_import, sort_child_properties_last, file_names, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sapili/constant/colors.dart';
import 'package:sapili/constant/quran.dart';
import 'package:sapili/controller/arabicnumberconverter.dart';
import 'package:sapili/controller/qurancontroller.dart';
import 'package:sapili/main.dart';
import 'package:sapili/view/widgets/last-surah-comp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/aladhan-comp.dart';
import '../widgets/arabicsurahnumber.dart';

class AyahScreen extends StatelessWidget {
  final String? ayah;
  final int? ayahNum;
  const AyahScreen({super.key, required this.ayah, required this.ayahNum});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuranController>(
        init: QuranController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: mainColor,
            appBar: AppBar(
              backgroundColor: mainColor,
              elevation: 0,
              title: Text(
                'سورة ${controller.currentSurah}',
                style: TextStyle(fontFamily: 'me_quran', wordSpacing: 6),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${ayah}'.trim(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'me_quran',
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                            Divider(
                              color: Colors.brown,
                              thickness: 0.2,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text(
                                  controller.currentAyahMeaning == null
                                      ? ''
                                      : controller.currentAyahMeaning!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'ArbFONTS',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.brown,
                              thickness: 0.2,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text(
                                  controller.currentAyahTafseer == null
                                      ? ''
                                      : controller.currentAyahTafseer!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'ArbFONTS',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  MaterialButton(
                    child: Container(
                      child: Center(
                        child: Text(
                          'اخذ لقطة شاشة',
                          style: TextStyle(
                              fontFamily: 'ArbFONTS',
                              fontSize: 17,
                              color: mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      width: Get.width - 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
        });
  }
}
