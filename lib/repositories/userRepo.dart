import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:rewayat_alkateb_islam/constants.dart';
import 'package:rewayat_alkateb_islam/models/user.dart';

class UserRepo {
  addUser() async {
    bool check = await checkUser();
    if (check == false) {
      print("new user");
      Response response = await Dio().post("$baseUrl/users/", data: {
        "firebaseId": auth.FirebaseAuth.instance.currentUser!.uid,
        "name": auth.FirebaseAuth.instance.currentUser!.displayName,
        "photoUrl": auth.FirebaseAuth.instance.currentUser!.photoURL
      });
      if (response.statusCode == 201) {
        print("created");
      }
    }
  }

  checkUser() async {
    print("checkUser user");

    Response response = await Dio()
        .get("$baseUrl/users/${auth.FirebaseAuth.instance.currentUser!.uid}");
    return response.data['success'];
  }

  getUser() async {
    late User user;
    Response response = await Dio()
        .get("$baseUrl/users/${auth.FirebaseAuth.instance.currentUser!.uid}");

    if (response.statusCode == 200) {
      user = User.fromJson(response.data['data']);
    }
    return user;
  }
}
