// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, avoid_unnecessary_containers, library_private_types_in_public_api, unused_field, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sapili/constant/colors.dart';
import 'package:sapili/controller/aladhancontroller.dart';

import '../../main.dart';
import '../screens/homepage.dart';
import 'salah-time-comp.dart';

class AlAdhanComponent extends StatelessWidget {
  const AlAdhanComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlAdhanController>(
      init: AlAdhanController(),
      builder: (controller) {
        return Container(
          width: Get.width,
          height: 90,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: ListView.builder(
              physics: BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.normal),
              scrollDirection: Axis.horizontal,
              itemCount: controller.aladhanTimeList.length,
              itemBuilder: (context, index) {
                return Center(
                  child: SalahTimeComponent(
                    salahName: controller.aladhanTimeList[index].salahName,
                    salahTime: controller.aladhanTimeList[index].salahTime,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
