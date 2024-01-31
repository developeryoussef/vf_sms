import 'package:get/get.dart';
import '../../constant/colors.dart';
import '../widgets/aladhan-comp.dart';
import 'package:flutter/material.dart';
import 'select-governorate-screen.dart';
import '../widgets/last-surah-comp.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../controller/navigationcontroller.dart';
import 'package:flutter/src/widgets/placeholder.dart';

// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, implementation_imports, unnecessary_import, sort_child_properties_last

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      init: NavigationController(),
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
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(SelectGovernorateScreen(),
                        transition: Transition.upToDown);
                  },
                  icon: Icon(LineIcons.locationArrow)),
            ],
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
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.normal),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LastSurahComponent(
                    url: 'assets/masgid.jpg',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'مواقيت الصلاة',
                        style: TextStyle(
                            fontFamily: 'ArbFONTS',
                            fontSize: 18,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  AlAdhanComponent(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الاقسام :',
                          style: TextStyle(
                              fontFamily: 'ArbFONTS',
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        MaterialButton(
                          child: Row(
                            children: [
                              Text(
                                'تحديث المواقيت',
                                style: TextStyle(
                                    fontFamily: 'ArbFONTS',
                                    color: secondColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Icon(
                                Icons.refresh,
                                color: secondColor,
                              )
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      controller.navToScreen(0);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            LineIcons.quran,
                            size: 65,
                            color: secondColor,
                          ),
                          Text(
                            'القرآن الكريم',
                            style: TextStyle(
                                fontFamily: 'ArbFONTS',
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: secondColor),
                          ),
                        ],
                      ),
                      width: Get.width - 35,
                      height: 120,
                      decoration: BoxDecoration(
                          color: mainColor.withOpacity(.3),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 2.5),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                LineIcons.hands,
                                size: 45,
                                color: secondColor,
                              ),
                              Text(
                                'الادعية',
                                style: TextStyle(
                                    fontFamily: 'ArbFONTS',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: secondColor),
                              ),
                            ],
                          ),
                          width: Get.width / 2.3,
                          height: 120,
                          decoration: BoxDecoration(
                              color: mainColor.withOpacity(.3),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 2.5),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                LineIcons.book,
                                size: 45,
                                color: secondColor,
                              ),
                              Text(
                                'الاذكار',
                                style: TextStyle(
                                    fontFamily: 'ArbFONTS',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: secondColor),
                              ),
                            ],
                          ),
                          width: Get.width / 2.3,
                          height: 120,
                          decoration: BoxDecoration(
                              color: mainColor.withOpacity(.3),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
