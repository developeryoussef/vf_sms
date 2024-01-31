// // ignore_for_file: file_names, unused_import, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mrs_geology_admin/controller/onboardingcontrollers.dart';
// import 'onboardingpage.dart';
// import '../../controller/pagesviewcontroller.dart';
// import '../../controller/pageviewpointcontroller.dart';

// class PageviewS extends GetView<OnBoardingControllerImp> {
//   const PageviewS({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     OnBoardingControllerImp controllerImp = Get.put(OnBoardingControllerImp());
//     return Expanded(
//       child: Container(
//           child: Column(
//         children: [
//           Expanded(
//             flex: 6,
//             child: PageView.builder(
//               physics: BouncingScrollPhysics(),
//               onPageChanged: (value) {
//                 controllerImp.onPageChanged(value);
//               },
//               itemCount: pageView.length,
//               itemBuilder: (context, index) {
//                 return pageView[index];
//               },
//             ),
//           ),
//           Spacer(),
//           Expanded(flex: 4, child: ConstantPart()),
//         ],
//       )),
//     );
//   }
// }

// class ConstantPart extends StatelessWidget {
//   const ConstantPart({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         PageViewSlider(),
//       ],
//     );
//   }
// }
