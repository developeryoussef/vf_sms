import 'package:get/get.dart';
import 'package:sapili/main.dart';
import '../../constant/azkar.dart';
import '../widgets/aladhan-comp.dart';
import 'package:flutter/material.dart';
import '../widgets/arabicsurahnumber.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sapili/constant/quran.dart';
import 'package:sapili/constant/colors.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../controller/arabicnumberconverter.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sapili/controller/qurancontroller.dart';
import 'package:sapili/view/widgets/last-surah-comp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sapili/controller/arabicnumberconverter.dart';
// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, implementation_imports, unnecessary_import, sort_child_properties_last, file_names, unnecessary_brace_in_string_interps

class AzkarScreen extends StatelessWidget {
  final String? currentAzkar;
  final List? currentAzkarList;
  const AzkarScreen(
      {super.key, required this.currentAzkar, required this.currentAzkarList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainLightColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        title: Text(
          '${currentAzkar}',
          style: TextStyle(fontFamily: 'ArbFONTS', wordSpacing: 6),
        ),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: currentAzkarList!.length,
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
                      currentAzkarList![index]['text'],
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      color: Colors.brown,
                      thickness: 0.1,
                    ),
                    Row(
                      children: [
                        Text(
                          currentAzkarList![index]['id']
                              .toString()
                              .toArabicNumbers,
                          style: TextStyle(
                              color: secondColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
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
      ),
    );
  }
}
