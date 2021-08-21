import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:rewayat_alkateb_islam/constants.dart';
import 'package:rewayat_alkateb_islam/models/user.dart';

class UserRepo {
 Future addUser() async {
 try {
      bool check = await checkUser();
    if (check == false) {
      print("new user");
      Response response = await Dio().post("$baseUrl/users/", data: {
        "firebaseId": auth.FirebaseAuth.instance.currentUser!.uid,
        "name": auth.FirebaseAuth.instance.currentUser!.displayName,
        "photoUrl": auth.FirebaseAuth.instance.currentUser!.photoURL,
        "referCode": "referal${auth.FirebaseAuth.instance.currentUser!.uid}",
      });
      if (response.statusCode == 201) {
        print("created");
      }
    }

    return check;
 } catch (e) {
 
 print(e);}
  }


  Future<bool> updateUserReferrer(refererCode)async{
   try {
      Response response = await Dio().put("$baseUrl/users/${auth.FirebaseAuth.instance.currentUser!.uid}/referrer", data: {
        "referrerCode":refererCode
      }); return response.data['success'];
   } catch (e) {
   print(e);     return false;

   }
  }

  Future<bool> updateList(referCode)async{
   try {
      Response response=await Dio().put("$baseUrl/users/referList/$referCode",data: {
      "userName":auth.FirebaseAuth.instance.currentUser!.displayName
    });

    return response.data['success'];
   } catch (e) {     print(e);

     return false;
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
