import 'dart:convert';
import 'package:get/get.dart';
import '../model/aladhanmodel.dart';
import '../constant/governorates.dart';
import 'package:http/http.dart' as http;
// ignore_for_file: unused_import, prefer_const_constructors, unused_local_variable, avoid_print

class GovernorateController extends GetxController {
  String? selectedGovernorate = governoratesList[5];
  updateGoverS() {
    update();
  }
}
