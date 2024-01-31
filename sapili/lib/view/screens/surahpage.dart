import '../../main.dart';
import 'ayahscreen.dart';
import 'package:get/get.dart';
import '../../constant/quran.dart';
import '../../constant/colors.dart';
import '../widgets/aladhan-comp.dart';
import 'package:flutter/material.dart';
import '../widgets/last-surah-comp.dart';
import '../widgets/arabicsurahnumber.dart';
import 'package:line_icons/line_icons.dart';
import '../../controller/qurancontroller.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../controller/arabicnumberconverter.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, implementation_imports, unnecessary_import, sort_child_properties_last, file_names, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

class SurahPage extends StatelessWidget {
  const SurahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuranController>(
      init: QuranController(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: mainLightColor,
            appBar: AppBar(
              backgroundColor: mainColor,
              elevation: 0,
              title: Text(
                'سورة ${controller.currentSurah} ',
                style: TextStyle(fontFamily: 'me_quran', wordSpacing: 6),
              ),
            ),
            body: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(10),
              physics: BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.normal),
              itemCount:
                  quranList[controller.currentIndex! - 1]['verses'].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${quranList[controller.currentIndex! - 1]['verses'][index]['text']}"
                                    .trim() +
                                "  \uFD3F" +
                                '${quranList[controller.currentIndex! - 1]['verses'][index]['id'].toString()}'
                                    .toArabicNumbers +
                                "\uFD3E".trim(),
                            style: TextStyle(
                                fontSize: 22.5,
                                fontFamily: 'me_quran',
                                color: Colors.black87,
                                fontWeight: FontWeight.w500),
                          ),
                          Divider(
                            color: Colors.brown,
                            thickness: 0.1,
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    controller.getAyahTafseer(int.parse(
                                        quranList[controller.currentIndex! - 1]
                                                ['verses'][index]['id']
                                            .toString()));
                                  },
                                  icon: Icon(
                                    LineIcons.language,
                                    color: mainColor,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.play_arrow_rounded,
                                    color: mainColor,
                                    size: 30,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    LineIcons.book,
                                    color: mainColor,
                                  )),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Get.snackbar('سبيلي', 'تم النسخ',
                                        duration: Duration(milliseconds: 700));
                                  },
                                  icon: Icon(
                                    LineIcons.copyAlt,
                                    color: mainColor,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ));
      },
    );
  }
}
