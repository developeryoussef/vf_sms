import '../screens.dart';
import 'custom_drawer.dart';
import 'package:get/get.dart';
import '../../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../widgets/home/my_drawer.dart';
import 'package:line_icons/line_icons.dart';
import '../../firebase/loading_status.dart';
import '../../models/quiz_paper_model.dart';
import '../../models/leader_boaed_model.dart';
import 'package:geo_hefny/configs/configs.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_separator/easy_separator.dart';
import '../../controllers/common/drawer_controller.dart';
import '../../controllers/quiz_paper/quiz_controller.dart';
import 'package:geo_hefny/widgets/common/custom_app_bar.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../../controllers/quiz_paper/quiz_papers_controller.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../controllers/leader_board/leader_board_controller.dart';

// ignore_for_file: unused_import

class HomeScreen extends GetView<MyDrawerController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuizPaperController _quizePprContoller = Get.put(QuizPaperController());
    final AuthController _auth = Get.find();
    final user = _auth.getUser();
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      drawer: FirebaseAuth.instance.currentUser?.uid == null
          ? Drawer(
              child: Column(
                children: [],
              ),
            )
          : MyDrawer(),
      body: GetBuilder<MyDrawerController>(
        builder: (_) => Container(
          decoration: BoxDecoration(gradient: mainGradient(context)),
          child: SafeArea(
            child: BackgroundDecoration(
              showGradient: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(kMobileScreenPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Builder(
                                builder: (_) {
                                  String label = 'اهلا بك';
                                  if (user != null) {
                                    label = 'اهلا ${user.displayName}';
                                  }
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      user != null
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  '${user.photoURL}'),
                                              radius: 35,
                                              backgroundColor: Colors.grey,
                                            )
                                          : Container(),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(label,
                                          style: kDetailsTS.copyWith(
                                              color: kOnSurfaceTextColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  );
                                },
                              ),
                            ],
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
                    height: 37.5,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(),
                      child: ContentArea(
                        addPadding: false,
                        child: Obx(
                          () => LiquidPullToRefresh(
                            height: 100,
                            springAnimationDurationInMilliseconds: 300,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                            onRefresh: () async {
                              _quizePprContoller.getAllPapers();
                            },
                            child: ListView.separated(
                              padding: UIParameters.screenPadding,
                              shrinkWrap: true,
                              itemCount: _quizePprContoller.allPapers.length,
                              itemBuilder: (BuildContext context, int index) {
                                return QuizPaperCard(
                                  model: _quizePprContoller.allPapers[index],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 20,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
