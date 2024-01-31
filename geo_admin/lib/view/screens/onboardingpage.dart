// // ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace

// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mrs_geology_admin/view/screens/pageview.dart';
// import '../../main.dart';
// import '../../viewcontroller.dart';

// class OnBoardingPage extends StatelessWidget {
//   const OnBoardingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 25,
//             ),
//             Align(
//               alignment: Alignment.topLeft,
//               child: MaterialButton(
//                 onPressed: () {
//                   Get.off(ViewController());
//                   sharedPreferences!.setBool('isPageview', true);
//                 },
//                 child: Container(
//                   width: 80,
//                   height: 45,
//                   child: Center(
//                     child: Text(
//                       'تخطي',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   decoration: BoxDecoration(
//                     color: shadedMainColor,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//               ),
//             ),
//             PageviewS(),
//           ],
//         ),
//       ),
//     );
//   }
// }
