//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:rewayat_alkateb_islam/repositories/userRepo.dart';
import 'package:rewayat_alkateb_islam/views/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  //FirebaseAuth firebaseAuth  = FirebaseAuth.instance;
  Future<dynamic> signInWithFacebook(BuildContext context) async {
    late UserCredential userCredential;
    late String refer = '';

    try {
      final result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);

        userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);

        if (FirebaseAuth.instance.currentUser != null) {
          print("adding user");
          EasyLoading.show();
          await UserRepo().addUser().then((value) async {
            if (!value) {
              EasyLoading.dismiss();
              await showAnimatedDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext contextt) {
                  return Directionality(
                      textDirection: TextDirection.rtl,
                      child: CustomDialog(
                        elevation: 10,
                        backgroundColor: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .2,
                              width: MediaQuery.of(context).size.width * .8,
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      'ادخل كود الدعوة',
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  TextField(
                                      onChanged: (v) {
                                        refer = v;
                                      },
                                      decoration: InputDecoration(
                                          hintText: "كود الدعوة")),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              if (refer.length > 7) {
                                                print(refer);
                                                EasyLoading.show();

                                                await UserRepo()
                                                    .updateList(refer)
                                                    .then((value) async {
                                                  if (value) {
                                                    await UserRepo()
                                                        .updateUserReferrer(
                                                            refer);
                                                    EasyLoading.dismiss();
                                                    Navigator.pop(context);
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            contextt)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "تاكد من ادخال كود صحيح او تخطي")));
                                                  }
                                                });
                                              } else {
                                                EasyLoading.dismiss();
                                                ScaffoldMessenger.of(contextt)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "تاكد من ادخال كود صحيح او تخطي")));
                                              }
                                            },
                                            child: Text("اكمل")),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("تخطي")),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ));
                },
                animationType: DialogTransitionType.size,
                curve: Curves.fastOutSlowIn,
                duration: Duration(seconds: 1),
              );
            }
          });
          EasyLoading.dismiss();
        }
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (ctx) => MyHomePage()),
            (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "اهلا بيك يا ${FirebaseAuth.instance.currentUser!.displayName}")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result.message!)));
        print(result.message);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }

    return userCredential;
  }
}
