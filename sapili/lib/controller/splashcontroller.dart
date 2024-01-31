import 'dart:async';
import 'package:get/get.dart';
import '../view/screens/viewcontroller.dart';
// ignore_for_file: unused_import



class SplashController extends GetxController {

  @override
  void onInit() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      Get.off(ViewController(), transition: Transition.downToUp);
      print('navigated');
    });
    super.onInit();
  }
}