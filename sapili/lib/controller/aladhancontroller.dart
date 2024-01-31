import 'dart:convert';
import 'package:get/get.dart';
import 'package:sapili/main.dart';
import '../model/aladhanmodel.dart';
import '../constant/governorates.dart';
import 'package:http/http.dart' as http;
// ignore_for_file: unused_import, prefer_const_constructors, unused_local_variable, avoid_print

class AlAdhanController extends GetxController {
  String baseUrl =
      'https://api.aladhan.com/v1/timingsByCity/${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}?city=${sharedPreferences!.getString('selectedGover') == null ? governoratesList[5] : sharedPreferences!.getString('selectedGover')}&country=Egypt&method=8';

  getAlAdhanTimeList() async {
    var response = await http.get(Uri.parse(baseUrl));
    var statusCode = response.statusCode;
    var responsebody = jsonDecode(response.body);
    print(responsebody['data']['timings']['Fajr']);
    aladhanTimeList.add(AlAdhanModel(
        salahName: 'الفجر',
        salahTime: responsebody['data']['timings']['Fajr'].toString()));
    aladhanTimeList.add(AlAdhanModel(
        salahName: 'الشروق',
        salahTime: responsebody['data']['timings']['Sunrise'].toString()));
    aladhanTimeList.add(AlAdhanModel(
        salahName: 'الظهر',
        salahTime: responsebody['data']['timings']['Dhuhr'].toString()));
    aladhanTimeList.add(AlAdhanModel(
        salahName: 'العصر',
        salahTime: responsebody['data']['timings']['Asr'].toString()));
    aladhanTimeList.add(AlAdhanModel(
        salahName: 'المغرب',
        salahTime: responsebody['data']['timings']['Maghrib'].toString()));
    aladhanTimeList.add(AlAdhanModel(
        salahName: 'العشاء',
        salahTime: responsebody['data']['timings']['Isha'].toString()));
    update();
  }

  List<AlAdhanModel> aladhanTimeList = [];

  @override
  void onInit() {
    getAlAdhanTimeList();
    super.onInit();
  }
}
