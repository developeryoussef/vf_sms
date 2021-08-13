//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:rewayat_alkateb_islam/repositories/userRepo.dart';
import 'package:rewayat_alkateb_islam/views/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  //FirebaseAuth firebaseAuth  = FirebaseAuth.instance;
  Future<dynamic> signInWithFacebook(BuildContext context) async {
    late UserCredential userCredential;

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
          await UserRepo().addUser();
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
