// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import, avoid_web_libraries_in_flutter, unused_import

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';

import '../view/widget/images.dart';

class PageViewSystem extends StatelessWidget {
  final Widget widget1;
  final Widget widget2;
  final ImageofonBoarding widget3;

  PageViewSystem(
      {required this.widget1, required this.widget2, required this.widget3});
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: PageController(),
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 7, child: widget3),
              Expanded(flex: 4, child: widget1),
              Expanded(
                flex: 3,
                child: widget2,
              )
            ],
          ),
        ),
      ],
    );
  }
}
