// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, avoid_unnecessary_containers, library_private_types_in_public_api, unused_field, use_key_in_widget_constructors, file_names, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sapili/constant/colors.dart';

import '../../main.dart';
import '../screens/homepage.dart';

class LastSurahComponent extends StatelessWidget {
  final String? url;
  const LastSurahComponent({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12, right: 12, left: 13),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'آخر قراءة :',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily: 'ArbFONTS',
                            fontWeight: FontWeight.w900,
                            fontSize: 17),
                      ),
                      Text(
                        'سورة ${sharedPreferences!.getString('lastsurah')}',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
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
                        color: Color.fromARGB(255, 255, 255, 255),
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
              image: AssetImage('${url}'))),
    );
  }
}
