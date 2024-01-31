import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import '../../core/constant/routes.dart';
import '../../core/services/services.dart';
import '../../core/class/statusrequest.dart';
import '../../data/datasource/remote/auth/login.dart';
import '../../core/functions/handingdatacontroller.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  goToForgetPassword();
}

class LoginControllerImp extends LoginController {
  LoginData loginData = LoginData(Get.find());

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;

  bool isshowpassword = true;

  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;

  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  @override
  login() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginData.postdata(email.text, password.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        print(response);
        if (response['_id'] != null) {
          myServices.sharedPreferences.setString("id", response['_id']);
          String userid = myServices.sharedPreferences.getString("id")!;
          myServices.sharedPreferences.setString("username", response['name']);
          myServices.sharedPreferences.setString("email", response['email']);
          myServices.sharedPreferences.setString("phone", response['phone']);
          myServices.sharedPreferences.setString("step", "2");

          Get.offNamed(AppRoute.homepage);
        } else {
          Get.toNamed(AppRoute.verfiyCodeSignUp,
              arguments: {"email": email.text});
        }
      } else {
        Get.defaultDialog(
            title: "ُWarning", middleText: "Email Or Password Not Correct");
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signUp);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }
}
