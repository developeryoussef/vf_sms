// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, implementation_imports, unnecessary_import, sort_child_properties_last, file_names

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

class SurahsPage extends StatelessWidget {
  const SurahsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuranController>(
      init: QuranController(),
      builder: (controller) {
        return Scaffold(
          drawer: Drawer(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                    accountName: null,
                    accountEmail: null,
                    decoration: BoxDecoration(color: mainColor)),
              ],
            ),
          ),
          appBar: AppBar(
            iconTheme: IconThemeData.fallback(),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              'سبيلي',
              style: TextStyle(
                  fontFamily: 'ArbFONTS',
                  color: thirdColor,
                  fontWeight: FontWeight.w900),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: LastSurahComponent(
                      url: 'assets/R.jfif',
                    )),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.normal),
                      itemCount: arabicName.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: secondColor,
                          ),
                          onTap: () {
                            controller.setLastSurah(
                                arabicName[index]['name'].toString(),
                                int.parse(arabicName[index]['surah']));
                            print(controller.currentIndex);
                            print(controller.currentSurah);
                          },
                          leading: ArabicSuraNumber(
                            i: int.parse(arabicName[index]['surah']),
                          ),
                          title: Text(
                            arabicName[index]['name'],
                            style: TextStyle(
                                fontFamily: 'me_quran',
                                color: mainColor,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'عدد آياتها  ${noOfVerses[int.parse(arabicName[index]['surah']) - 1].toArabicNumbers.toString()}',
                            style: TextStyle(
                                fontFamily: 'ArbFONTS',
                                color: secondColor,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                    width: Get.width,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
