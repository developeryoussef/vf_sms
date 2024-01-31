// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import, avoid_print, body_might_complete_normally_nullable, unnecessary_brace_in_string_interps, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class QuizController extends GetxController {
  int index = 1;

  TextEditingController? quiznumber = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  TextEditingController option4Controller = TextEditingController();
  TextEditingController answerController = TextEditingController();

  changeIndex() {
    index++;
    update();
  }
}
