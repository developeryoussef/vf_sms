// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, avoid_unnecessary_containers, library_private_types_in_public_api, unused_field, use_key_in_widget_constructors, file_names, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sapili/constant/colors.dart';

import '../../main.dart';
import '../screens/homepage.dart';

class SalahTimeComponent extends StatelessWidget {
  final String? salahName;
  final String? salahTime;
  const SalahTimeComponent(
      {super.key, required this.salahName, required this.salahTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.5),
      width: Get.width / 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: mainColor.withOpacity(.9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${salahName}',
            style: TextStyle(
                fontFamily: 'ArbFONTS',
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              '${salahTime}',
              style: TextStyle(
                  fontFamily: 'ArbFONTS',
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
