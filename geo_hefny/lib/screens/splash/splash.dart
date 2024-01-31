import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../configs/themes/app_colors.dart';
import '../../configs/themes/light_theme.dart';
import '../../widgets/common/main_button.dart';
import '../../configs/themes/ui_parameters.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../configs/themes/custom_text_styles.dart';
import 'package:geo_hefny/controllers/auth_controller.dart';

class SplashScreen extends GetView<AuthController> {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              opacity: .75,
              fit: BoxFit.cover,
              image: AssetImage('assets/OIP.jpeg')),
        ),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.005,
                    1
                  ],
                  colors: [
                    Colors.transparent,
                    Color.fromARGB(255, 53, 53, 53)
                  ]),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Picture1.png',
                  width: Get.width - 100,
                ),
                Text(
                  'ElGeo Hefny',
                  style: TextStyle(
                      fontFamily: kAppBarTS.fontFamily,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Text(
                    FirebaseAuth.instance.currentUser?.uid == null
                        ? 'يمكنك تسجيل بحساب جوجل الخاص بك على الجهاز ويسمح لذلك بأخذ اسم المستخدم و صورة حسابه'
                        : 'تطبيق امتحانات جيولوجيا للصف الثالث الثانوي للأستاذ القدير محمد حفني',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'ArbFONTS',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FirebaseAuth.instance.currentUser?.uid == null
                    ? MainButton(
                        onTap: () {
                          controller.siginInWithGoogle();
                        },
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/google.png'),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'تسجيل بحساب بجوجل',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontFamily: 'ArbFONTS',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )
                    : MainButton(
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 28,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'استمرار',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          controller.navigateToHome();
                        },
                      ),
              ],
            )),
      ),
    );
  }
}
