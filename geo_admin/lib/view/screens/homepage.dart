// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, unused_local_variable, avoid_print, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controller/quizpagecontroller.dart';
import '../widget/quizpapercard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return QuizesView();
  }
}

class QuizesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuizPaperController _quizePprContoller = Get.put(QuizPaperController());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.5),
            child: Obx(
              () => ListView.separated(
                shrinkWrap: true,
                itemCount: _quizePprContoller.allPapers.length,
                itemBuilder: (BuildContext context, int index) {
                  print(_quizePprContoller.allPapers);
                  return QuizPaperCard(
                    model: _quizePprContoller.allPapers[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
              ),
            ),
          ),
        ),
        width: Get.width - 20,
        height: Get.height - 20,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
