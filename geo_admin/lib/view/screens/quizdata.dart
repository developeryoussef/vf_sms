// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import, avoid_print, body_might_complete_normally_nullable, unnecessary_brace_in_string_interps, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/addquizcontroller.dart';
import '../../main.dart';
import '../widget/custom_textfield.dart';

class TestedQuiz extends StatelessWidget {
  final String? primary;
  const TestedQuiz({super.key, required this.primary});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      init: QuizController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor,
            title: Text('Students has tested quiz'),
          ),
          body: Center(
            child: Text('No studnet has tested this quiz'),
          ),
        );
      },
    );
  }
}
