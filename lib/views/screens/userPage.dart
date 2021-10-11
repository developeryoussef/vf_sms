import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:rewayat_alkateb_islam/blocs/bloc/user_bloc.dart';
import 'package:rewayat_alkateb_islam/constants.dart';
import 'package:rewayat_alkateb_islam/views/screens/authScreen.dart';
import 'package:rewayat_alkateb_islam/views/screens/videoPage.dart';
import 'package:share/share.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late String earningVideoId;
loadVideoId()async{
  Response response=await Dio().get("$baseUrl/voiceNovels/earnVideo");
  if(response.statusCode==200){
    earningVideoId=response.data[0]['videoId'];
  }
}
  @override
  void initState() {
    loadVideoId();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kMainColor,
        centerTitle: true,
        title: Text(
          "حسابي",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo'),
        ),
        brightness: Brightness.dark,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is UserLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: _height * .03,
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        'اهلا بيك ${FirebaseAuth.instance.currentUser!.displayName}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _height * .02,
                  ),
                  CircleAvatar(
                    radius: 65,
                    backgroundColor: kMainColor,
                    foregroundImage: AssetImage("assets/images/avatar.png"),
                  ),
                  SizedBox(
                    height: _height * .03,
                  ),
                  Bounce(
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: "${state.user.firebaseId}"));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("تم نسخ الاي دي الخاص بك")));
                    },
                    duration: Duration(milliseconds: 100),
                    child: Material(
                      shape: SuperellipseShape(
                          borderRadius: BorderRadius.circular(26)),
                      color: Colors.white,
                      shadowColor: Colors.grey,
                      elevation: 5,
                      child: Container(
                        width: _width * .5,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "نسخ الاي دي الخاص بك",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _height * .03,
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        'الرصيد الخاص بك',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _height * .02,
                  ),
                  Material(
                    shape: SuperellipseShape(
                        borderRadius: BorderRadius.circular(26)),
                    color: Colors.white,
                    shadowColor: Colors.grey,
                    elevation: 5,
                    child: Container(
                      width: _width * .8,
                      height: _height * .1,
                      child: Center(
                        child: Text(
                          state.user.points.toStringAsFixed(1) + ' Point',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Cairo',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),   SizedBox(
                    height: _height * .02,
                  ),
                  GradientButton(
                      shapeRadius: BorderRadius.circular(6),
                      increaseWidthBy: _width * .7,
                      increaseHeightBy: 2,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      gradient: LinearGradient(colors: [
                        kMainColor,
                        Color(0xFF02A2FF),
                      ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "الربح من التطبيق",
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      callback: () async {
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>VideoApp(videoId: earningVideoId)));
                      }),
               
                  SizedBox(
                    height: _height * .02,
                  ),
                  GradientButton(
                      shapeRadius: BorderRadius.circular(6),
                      increaseWidthBy: _width * .7,
                      increaseHeightBy: 2,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      gradient: LinearGradient(colors: [
                        kMainColor,
                        Color(0xFF02A2FF),
                      ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "طلب سحب الاموال",
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      callback: () async {
                        //FlutterOpenWhatsapp.sendSingleMessage("918179015345", "Hello");
                        if (state.user.points >= 2500) {
                          final link = WhatsAppUnilink(
                            phoneNumber: '+201030538962',
                            text: "hey \ni want to get " +
                                state.user.points.toStringAsFixed(1) +
                                ' \$' +
                                " \nmy Id is ${FirebaseAuth.instance.currentUser!.uid} \nThx",
                          );
                          // Convert the WhatsAppUnilink instance to a string.
                          // Use either Dart's string interpolation or the toString() method.
                          // The "launch" method is part of "url_launcher".
                          await launch('$link', universalLinksOnly: true);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("اقل كمية للسحب 2500 نقطة")));
                        }
                      }),
                  SizedBox(
                    height: _height * .04,
                  ),
                  Bounce(
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: "${state.user.referCode}"));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "تم نسخ كود الاحالة ${state.user.referCode}")));
                    },
                    duration: Duration(milliseconds: 100),
                    child: Material(
                      shape: SuperellipseShape(
                          borderRadius: BorderRadius.circular(26)),
                      color: Colors.white,
                      shadowColor: Colors.grey,
                      elevation: 5,
                      child: Container(
                        width: _width * .5,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "نسخ كود الدعوة الخاص بك",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Bounce(
                    duration: Duration(milliseconds: 100),
                    onPressed: () {
                      if (state.user.referredUsers.length > 0) {
                        showAnimatedDialog(
                            context: context,
                            builder: (builder) {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: ClassicListDialogWidget(
                                  positiveText: "حسنا",
                                  dataList: state.user.referredUsers,
                                  listType: ListType.single,
                                  titleText: "دعواتك",
                                ),
                              );
                            });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("لم تقم بدعوة احد حتي الان")));
                      }
                    },
                    child: Material(
                      shape: SuperellipseShape(
                          borderRadius: BorderRadius.circular(26)),
                      color: Colors.white,
                      shadowColor: Colors.grey,
                      elevation: 5,
                      child: Container(
                        width: _width * .5,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "دعواتك",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  /* Container(
                    width: _width*.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,boxShadow: 
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("نسخ كود الدعوة الخاص بك",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
                      ),
                    ),
                  ),*/
                  SizedBox(
                    height: _height * .08,
                  ),
                  GradientButton(
                      shapeRadius: BorderRadius.circular(6),
                      increaseWidthBy: _width * .7,
                      increaseHeightBy: 2,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      gradient: LinearGradient(colors: [
                        kMainColor,
                        Color(0xFF02A2FF),
                      ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "مشاركة التطبيق",
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      callback: () async {
                        Share.share(
                            "https://play.google.com/store/apps/details?id=com.app.rewayat_alkateb_islam");
                      }),
                  SizedBox(
                    height: _height * .01,
                  ),
                  GradientButton(
                      shapeRadius: BorderRadius.circular(6),
                      increaseWidthBy: _width * .7,
                      increaseHeightBy: 2,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      gradient: LinearGradient(colors: [
                        kMainColor,
                        Color(0xFF02A2FF),
                      ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "تسجيل الخروج",
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      callback: () async {
                        await FirebaseAuth.instance.signOut();
                        if (FirebaseAuth.instance.currentUser == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            "تم تسجيل الخروج بنجاح",
                            style: TextStyle(color: Colors.white),
                          )));
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (ctx) => AuthScreen()),
                              (route) => false);
                        }
                      }),
                ],
              ),
            );
          } else if (state is UserError) {
            return Container(
              child: Center(
                child: Text("coudn't load data, Try Again later"),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
