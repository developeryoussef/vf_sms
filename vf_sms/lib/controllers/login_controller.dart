import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:vf_sms/main.dart';
import '../view/viewcontroller.dart';
import '../core/data/login_data.dart';
import 'package:flutter/material.dart';
import '../core/classes/statusrequest.dart';
import '../core/functions/handling_data.dart';
import 'package:vf_sms/core/classes/crud.dart';

// ignore_for_file: unused_import

class LoginController extends GetxController {
  StatusRequest? statusRequest;
  GlobalKey<FormState> loginFormKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool hidPass = true;
  String errorMessage = '';
  String? errorTextEmail;
  String? errorTextPassword;
  StateMachineController? machineController;

  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  bool uploading = false;
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return errorTextEmail = 'Please enter an email address';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return errorTextEmail = 'Please enter a valid email address';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return errorTextPassword = 'Please enter Your Name';
    } else {
      return errorTextPassword = null;
    }
  }

  LoginData loginData = LoginData(Get.find());

  login() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await loginData.postdata(
        emailController.text.toString(), passController.text.toString());
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['_id'] != null) {
        sharedPreferences!.setString('email', response['email']);
        sharedPreferences!.setString('username', response['name']);
        sharedPreferences!.setString('id', response['_id']);
        sharedPreferences!.setString('phone', response['phone']);
        sharedPreferences!.setString('apptoken', response['tokenApp']);
        sharedPreferences!.setBool('isLogin', true);
        Get.offAll(ViewController());
      }
    } else {
      Get.defaultDialog(
          title: "ُWarning", middleText: "Email Or Password Not Correct");
      statusRequest = StatusRequest.failure;
    }
    update();
  }
}
