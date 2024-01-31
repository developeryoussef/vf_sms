import '../../main.dart';
import 'azkar-screen.dart';
import 'package:get/get.dart';
import '../../constant/azkar.dart';
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
// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, implementation_imports, unnecessary_import, sort_child_properties_last, file_names

class AzkarCategoriesScreen extends StatelessWidget {
  const AzkarCategoriesScreen({super.key});

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
            body: Column(
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.only(top: 5, right: 12, left: 13),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'يوم الأحد',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontFamily: 'ArbFONTS',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 27),
                              ),
                              Text(
                                '${DateTime.now().minute} : ${DateTime.now().hour}',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontFamily: 'ArbFONTS',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 27),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'آخر قراءة اذكار',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontFamily: 'ArbFONTS',
                                            fontWeight: FontWeight.w900,
                                            fontSize: 17),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    '${DateTime.now().day} - ${DateTime.now().month} - ${DateTime.now().year}',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontFamily: 'ArbFONTS',
                                        fontWeight: FontWeight.w900,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      margin: EdgeInsets.symmetric(vertical: 15),
                      width: Get.width - 35,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              opacity: 0.75,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.fill,
                              image: AssetImage('assets/OIP.jpg'))),
                    )),
                Expanded(
                  flex: 5,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: azkarList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Get.to(AzkarScreen(
                            currentAzkarList: azkarList[index]['array'],
                            currentAzkar: azkarList[index]['category'],
                          ));
                        },
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: secondColor,
                        ),
                        subtitle: Text(
                          'عدد الاذكار بالقسم : ${azkarList[index]['array'].length.toString()}',
                          style: TextStyle(
                              fontFamily: 'ArbFONTS',
                              color: mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                        leading: ArabicSuraNumber(
                          i: azkarList[index]['id'],
                        ),
                        title: Text(
                          azkarList[index]['category'],
                          style: TextStyle(
                              fontFamily: 'ArbFONTS',
                              color: secondColor,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
