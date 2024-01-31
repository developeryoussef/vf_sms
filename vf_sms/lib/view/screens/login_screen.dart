import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vf_sms/core/constants/colors.dart';
import 'package:vf_sms/core/classes/statusrequest.dart';
import 'package:vf_sms/controllers/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore_for_file: prefer_const_constructors

// ignore_for_file: unused_import

// ignore_for_file: avoid_print, unused_local_variable

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Login',
              style: GoogleFonts.mPlusRounded1c(
                color: Colors.grey[850],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: size.width / 2,
                        height: size.width / 2,
                        child: ClipOval(
                          child: RiveAnimation.asset(
                            'assets/login_animated_character.riv',
                            fit: BoxFit.cover,
                            stateMachines: const ["Login Machine"],
                            onInit: (artboard) {
                              controller.machineController =
                                  StateMachineController.fromArtboard(
                                      artboard, "Login Machine");
                              artboard
                                  .addController(controller.machineController!);
                              controller.isChecking = controller
                                  .machineController
                                  ?.findInput("isChecking");
                              controller.isHandsUp = controller
                                  .machineController
                                  ?.findInput("isHandsUp");
                              controller.trigSuccess = controller
                                  .machineController
                                  ?.findInput("trigSuccess");
                              controller.trigFail = controller.machineController
                                  ?.findInput("trigFail");
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              controller.errorMessage,
                              style: GoogleFonts.mPlusRounded1c(
                                color: Colors.red[900],
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: controller.loginFormKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: controller.emailController,
                                      validator: controller.validateEmail,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.email_rounded,
                                        ),
                                        hintText: 'Email',
                                        label: Text(
                                          'Email',
                                          style: GoogleFonts.mPlusRounded1c(
                                            color: Colors.grey[850],
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 2.5,
                                              color: Colors.grey[850] ??
                                                  Colors.transparent,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        errorText: controller.errorTextEmail,
                                        errorStyle: GoogleFonts.mPlusRounded1c(
                                          color: Colors.red[900],
                                          fontSize: 14,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (controller.isHandsUp != null) {
                                          controller.isHandsUp!.change(false);
                                        }
                                        if (controller.isChecking == null)
                                          return;

                                        controller.isChecking!.change(true);
                                      },
                                      cursorColor: Colors.grey[850],
                                      cursorRadius: const Radius.circular(25),
                                      cursorWidth: 2.5,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: TextFormField(
                                      obscureText: controller.hidPass,
                                      controller: controller.passController,
                                      validator: controller.validatePassword,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.lock_rounded,
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            // setState(() {
                                            //   controller.hidPass = !controller.hidPass;
                                            // });
                                          },
                                          icon: Icon(
                                            controller.hidPass == true
                                                ? Icons.visibility_off_rounded
                                                : Icons.visibility_rounded,
                                          ),
                                        ),
                                        hintText: 'Password',
                                        label: Text(
                                          'Password',
                                          style: GoogleFonts.mPlusRounded1c(
                                            color: Colors.grey[850],
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 2.5,
                                              color: Colors.grey[850] ??
                                                  Colors.transparent,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        errorText: controller.errorTextPassword,
                                        errorStyle: GoogleFonts.mPlusRounded1c(
                                          color: Colors.red[900],
                                          fontSize: 14,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (controller.isChecking != null) {
                                          controller.isChecking!.change(false);
                                        }
                                        if (controller.isHandsUp == null)
                                          return;

                                        controller.isHandsUp!.change(true);
                                      },
                                      cursorColor: Colors.grey[850],
                                      cursorRadius: const Radius.circular(25),
                                      cursorWidth: 2.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: size.width - 50,
                              height: size.width / 8,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (controller.loginFormKey.currentState!
                                      .validate()) {
                                    controller.login();
                                  }
                                },
                                style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  backgroundColor:
                                      MaterialStatePropertyAll(secondryColor),
                                ),
                                child: controller.statusRequest != StatusRequest.loading ? Text(
                                  'Sign In',
                                  style: GoogleFonts.mPlusRounded1c(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ) : CircularProgressIndicator(color: Colors.white,),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
