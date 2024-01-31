import '../screens.dart';
import 'package:get/get.dart';
import '../../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../firebase/loading_status.dart';
import '../../models/quiz_paper_model.dart';
import '../../configs/themes/app_colors.dart';
import '../../models/leader_boaed_model.dart';
import '../../configs/themes/light_theme.dart';
import '../../controllers/auth_controller.dart';
import '../../configs/themes/ui_parameters.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/common/custom_app_bar.dart';
import 'package:easy_separator/easy_separator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../configs/themes/custom_text_styles.dart';
import '../../controllers/profile/profile_controller.dart';
import '../../controllers/quiz_paper/quiz_controller.dart';
import '../../controllers/leader_board/leader_board_controller.dart';
// ignore_for_file: unused_local_variable, unnecessary_cast

// ignore_for_file: unused_import

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController _auth = Get.find<AuthController>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BackgroundDecoration(
        showGradient: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: UIParameters.screenPadding.copyWith(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      'امتحاناتك السابقة',
                      style: TextStyle(
                          fontSize: 25,
                          color: kOnSurfaceTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/dinosaur.png',
                  color: Colors.white,
                  width: 33,
                ),
                Image.asset(
                  'assets/diplodocus.png',
                  color: Colors.white,
                  width: 33,
                ),
                Image.asset(
                  'assets/fossil2.png',
                  color: Colors.white,
                  width: 33,
                ),
                Image.asset(
                  'assets/triceratops.png',
                  color: Colors.white,
                  width: 33,
                ),
                Image.asset(
                  'assets/tyrannosaurus-rex.png',
                  width: 33,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/fossil.png',
                  width: 33,
                ),
                Image.asset(
                  'assets/volcano.png',
                  width: 33,
                ),
                Image.asset(
                  'assets/geology (3).png',
                  width: 33,
                ),
                Image.asset(
                  'assets/geology (1).png',
                  width: 33,
                ),
                Image.asset(
                  'assets/earth-crust.png',
                  width: 33,
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: ContentArea(
                addPadding: true,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser?.email)
                      .collection('myrecent_quizes')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: seconderyColor,
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: RecentQuizCard(
                            points: data['points'].toString(),
                            time: data['time'].toString(),
                            correctCount: data['correct_count'].toString(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
