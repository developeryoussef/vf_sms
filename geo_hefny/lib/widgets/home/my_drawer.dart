import 'package:firebase_auth/firebase_auth.dart';
import 'package:geo_hefny/configs/configs.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../configs/themes/ui_parameters.dart';

import 'package:get/get.dart';
import '../../screens/splash/splash.dart';
import '../../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../firebase/loading_status.dart';
import '../../models/quiz_paper_model.dart';
import '../../configs/themes/app_colors.dart';
import '../../models/leader_boaed_model.dart';
import '../../controllers/auth_controller.dart';
import 'package:easy_separator/easy_separator.dart';
import '../../configs/themes/custom_text_styles.dart';
import '../../controllers/common/drawer_controller.dart';
import '../../controllers/quiz_paper/quiz_controller.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../controllers/quiz_paper/quiz_papers_controller.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../controllers/leader_board/leader_board_controller.dart';
// ignore_for_file: unused_import

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    QuizPaperController _quizePprContoller = Get.put(QuizPaperController());
    final AuthController _auth = Get.find();
    final user = _auth.getUser();
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: user != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage('${user.photoURL}'),
                      radius: 35,
                      backgroundColor: Colors.grey,
                    )
                  : Container(),
              decoration: BoxDecoration(gradient: mainGradientLT),
              accountName: Text(user!.email!.toString()),
              accountEmail: Text(user.displayName!.toString())),
          ListTile(
            onTap: () async {
              await launchUrl(Uri.parse('tel://01003658856'));
            },
            leading: Icon(
              LineIcons.phone,
              color: Colors.grey.shade800,
              size: 27,
            ),
            title: Text(
              'تواصل معنا',
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
            trailing: Icon(Icons.arrow_back_ios_new),
          ),
          ListTile(
            onTap: () async {
              await launchUrl(Uri.parse('https://wa.me/01003658856'));
            },
            leading: Icon(
              LineIcons.whatSApp,
              color: Colors.green,
              size: 27,
            ),
            title: Text(
              'تواصل معنا واتساب',
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
            trailing: Icon(Icons.arrow_back_ios_new),
          ),
          ListTile(
            onTap: () async {
              await launchUrl(
                  Uri.parse('https://www.facebook.com/groups/228011529863431'));
            },
            leading: Icon(
              LineIcons.facebook,
              color: Color.fromARGB(255, 33, 86, 243),
              size: 27,
            ),
            title: Text(
              'جروب الفيسبوك',
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
            trailing: Icon(Icons.arrow_back_ios_new),
          ),
          ListTile(
            onTap: () async {
              await launchUrl(Uri.parse(''));
            },
            leading: Icon(
              Icons.privacy_tip_outlined,
              color: Color.fromARGB(255, 243, 33, 114),
              size: 27,
            ),
            title: Text(
              'سياسة الخصوصية',
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
            trailing: Icon(Icons.arrow_back_ios_new),
          ),
          Spacer(),
          ListTile(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Get.offAll(SplashScreen());
              },
              title: Text(
                'تسجيل الخروج',
                style: TextStyle(
                  fontFamily: 'ArbFONTS',
                ),
              ),
              subtitle: Text(
                '${FirebaseAuth.instance.currentUser?.email!}',
                style: TextStyle(
                  fontFamily: 'ArbFONTS',
                ),
              ),
              trailing: Icon(
                Icons.arrow_back_ios_new,
              ),
              leading: Icon(
                Icons.logout,
                color: seconderyColor,
              )),
        ],
      ),
    );
  }
}
