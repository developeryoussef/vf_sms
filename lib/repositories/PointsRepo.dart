import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rewayat_alkateb_islam/blocs/bloc/messages_bloc.dart';
import 'package:rewayat_alkateb_islam/constants.dart';
import 'package:rewayat_alkateb_islam/models/user.dart';
import 'package:rewayat_alkateb_islam/views/screens/chatScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PointsRepo {
  increasePoints() async {
    print("increasing");

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    double? points = sharedPreferences.getDouble("PointsPerAd");
    double? creditPriceFor1KPoints =
        sharedPreferences.getDouble("creditPriceFor1kPoints");

    Response response = await Dio().put(
        "$baseUrl/users/fb/${auth.FirebaseAuth.instance.currentUser!.uid}",
        data: {
          "points": points,
          "credit": ((points! / 1000) * creditPriceFor1KPoints!)
        });
    if (response.statusCode == 200) {
      print("increased");
    }
  }

  Future<bool> increaseFromVideoWatching() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    double? pointsPerHour = sharedPreferences.getDouble("pointsPerHour");
    double pointsPerMinute = pointsPerHour! / 60;
    double? creditPriceFor1KPoints =
        sharedPreferences.getDouble("creditPriceFor1kPoints");

    Response response = await Dio().put(
        "$baseUrl/users/fb/${auth.FirebaseAuth.instance.currentUser!.uid}",
        data: {
          "points": (pointsPerMinute),
          "credit": ((pointsPerMinute / 1000) * creditPriceFor1KPoints!)
        });
    if (response.statusCode == 200) {
      print("increased");
      return true;
    } else {
      return false;
    }
  }

  decreaseForSolveMyProblem(context) async {
    EasyLoading.show();
    Response response = await Dio().get(
        "$baseUrl/messaging/check/${auth.FirebaseAuth.instance.currentUser!.uid}admin");
 
    if (response.data['exists'] == true) {
      EasyLoading.dismiss();
       Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => BlocProvider(
                      create: (context) => MessagesBloc()..add(FetchMessages()),
                      child: ChatPage(),
                    )));
    /*  Response response = await Dio().get(
          "$baseUrl/messaging/${auth.FirebaseAuth.instance.currentUser!.uid}admin");
      print(response.data);
      if (response.data['isChatAcive'] == true) {
        print("is active");
        //TODO ADD THE BLOC FOR FETCHING MESSAGES
        EasyLoading.dismiss();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => BlocProvider(
                      create: (context) => MessagesBloc()..add(FetchMessages()),
                      child: ChatPage(),
                    )));
      } else {
        bool isEnough = await isEnoughPoints();

        if (isEnough) {
          EasyLoading.dismiss();
          showAnimatedDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: ClassicGeneralDialogWidget(
                  titleText: 'حللي مشكلتي',
                  contentText: 'علشان اساعدك في حل مشكلتك سيتم خصم 200 نقطة',
                  negativeText: "الغاء",
                  positiveText: "اكمل",
                  onPositiveClick: () async {
                    EasyLoading.show();

                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    double? points = -200;
                    double? creditPriceFor1KPoints =
                        sharedPreferences.getDouble("creditPriceFor1kPoints");
                    Response responsee = await Dio().put(
                        "$baseUrl/users/fb/${auth.FirebaseAuth.instance.currentUser!.uid}",
                        data: {
                          "points": (points),
                          "credit": ((points / 1000) * creditPriceFor1KPoints!)
                        });

                    Response response = await Dio().patch(
                        "$baseUrl/messaging/${auth.FirebaseAuth.instance.currentUser!.uid}admin");
                    if (response.statusCode == 200) {
                      Navigator.of(context).pop();

                      EasyLoading.dismiss();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => BlocProvider(
                                    create: (context) =>
                                        MessagesBloc()..add(FetchMessages()),
                                    child: ChatPage(),
                                  )));
                    }
                  },
                  onNegativeClick: () {
                    EasyLoading.dismiss();

                    Navigator.of(context).pop();
                  },
                ),
              );
            },
            animationType: DialogTransitionType.size,
            curve: Curves.fastOutSlowIn,
            duration: Duration(seconds: 1),
          );
          EasyLoading.dismiss();
        } else {
          EasyLoading.dismiss();

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("ليس معك نقاط كافية")));
        }
      }*/
    } else {
       Response response =
                      await Dio().post("$baseUrl/messaging/", data: {
                    "roomId":
                        (auth.FirebaseAuth.instance.currentUser!.uid + "admin"),
                    "roomName":
                        (auth.FirebaseAuth.instance.currentUser!.displayName)
                  });
EasyLoading.dismiss();
       Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => BlocProvider(
                      create: (context) => MessagesBloc()..add(FetchMessages()),
                      child: ChatPage(),
                    )));

   /*   bool isEnough = await isEnoughPoints();
      print(isEnoughPoints());
      // ignore: unrelated_type_equality_checks
      if (isEnough) {
        EasyLoading.dismiss();
        showAnimatedDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: ClassicGeneralDialogWidget(
                titleText: 'حللي مشكلتي',
                contentText: 'علشان اساعدك في حل مشكلتك سيتم خصم 200 نقطة',
                negativeText: "الغاء",
                positiveText: "اكمل",
                onPositiveClick: () async {
                  EasyLoading.show();
                  Response response =
                      await Dio().post("$baseUrl/messaging/", data: {
                    "roomId":
                        (auth.FirebaseAuth.instance.currentUser!.uid + "admin"),
                    "roomName":
                        (auth.FirebaseAuth.instance.currentUser!.displayName)
                  });

                  if (response.statusCode == 200) {
                    //TODO ADD THE BLOC FOR FETCHING MESSAGES
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    double? points = -200;
                    double? creditPriceFor1KPoints =
                        sharedPreferences.getDouble("creditPriceFor1kPoints");
                    Response response = await Dio().put(
                        "$baseUrl/users/fb/${auth.FirebaseAuth.instance.currentUser!.uid}",
                        data: {
                          "points": (points),
                          "credit": ((points / 1000) * creditPriceFor1KPoints!)
                        });
                    if (response.statusCode == 200) {
                      Navigator.of(context).pop();

                      EasyLoading.dismiss();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => BlocProvider(
                                    create: (context) =>
                                        MessagesBloc()..add(FetchMessages()),
                                    child: ChatPage(),
                                  )));
                    }
                  }
                },
                onNegativeClick: () {
                  EasyLoading.dismiss();

                  Navigator.of(context).pop();
                },
              ),
            );
          },
          animationType: DialogTransitionType.size,
          curve: Curves.fastOutSlowIn,
          duration: Duration(seconds: 1),
        );
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("ليس معك نقاط كافية")));
      }*/
    }
  }

  Future<bool> isEnoughPoints() async {
    late User user;
    Response responsee = await Dio().get(
      "$baseUrl/users/${auth.FirebaseAuth.instance.currentUser!.uid}",
    );
    if (responsee.statusCode == 200) {
      user = User.fromJson(responsee.data['data']);
    }
    print(responsee.data);
    return (user.points) >= 200;
  }
}
