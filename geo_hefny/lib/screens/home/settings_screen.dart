import 'package:firebase_auth/firebase_auth.dart';
import 'package:geo_hefny/configs/configs.dart';
import 'package:geo_hefny/screens/screens.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColorLT,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'الاعدادات',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontFamily: 'ArbFONTS',
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(
            parent: ScrollPhysics(),
            decelerationRate: ScrollDecelerationRate.normal),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                width: Get.width,
                padding: EdgeInsets.all(5),
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        '${FirebaseAuth.instance.currentUser?.photoURL}'),
                    radius: 65,
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
              Account(),
              SizedBox(
                height: 4,
              ),
              Contact(),
              SizedBox(
                height: 4,
              ),
              Other(),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(8),
                color: Colors.white,
                child: ListTile(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.offAll(SplashScreen());
                    },
                    title: Text(
                      'تسجيل الخروج',
                      style: TextStyle(
                        fontFamily: 'ArbFONTS',
                      ),
                    ),
                    subtitle: Text(
                      '${FirebaseAuth.instance.currentUser?.email!}',
                      style: TextStyle(
                        fontFamily: 'ArbFONTS',
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_back_ios_new,
                    ),
                    leading: Icon(
                      Icons.logout,
                      color: seconderyColor,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                child: Center(
                  child: Container(
                    height: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await launchUrl(Uri.parse(
                                'https://www.facebook.com/sedrahomecare?mibextid=LQQJ4d'));
                          },
                          child: Expanded(
                            child: Icon(
                              LineIcons.facebook,
                              size: 28,
                              color: seconderyColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await launchUrl(
                                Uri.parse('https://sedrahcare.com'));
                          },
                          child: Expanded(
                            child: Icon(
                              Icons.web,
                              size: 28,
                              color: seconderyColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await launchUrl(
                                Uri.parse('https://twitter.com/sedrahcare'));
                          },
                          child: Expanded(
                            child: Icon(
                              size: 28,
                              LineIcons.twitter,
                              color: seconderyColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await launchUrl(Uri.parse(
                                'https://instagram.com/sedrahcare?igshid=OGQ5ZDc2ODk2ZA=='));
                          },
                          child: Expanded(
                            child: Icon(
                              LineIcons.instagram,
                              size: 28,
                              color: seconderyColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await launchUrl(Uri.parse(
                                "whatsapp://send?phone=+966114170700"));
                          },
                          child: Expanded(
                            child: Icon(
                              LineIcons.whatSApp,
                              size: 28,
                              color: seconderyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                'شروط الاستخدام  .  سياسة خصوصية',
                style: TextStyle(
                    fontFamily: 'ArbFONTS',
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Other extends StatelessWidget {
  const Other({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
              onTap: () async {
                await launchUrl(Uri.parse('tel://+9660114170700'));
              },
              title: Text(
                'مساعدة',
                style: TextStyle(
                  fontFamily: 'ArbFONTS',
                ),
              ),
              subtitle: Text(
                'يمكننا مساعدتك',
                style: TextStyle(
                  fontFamily: 'ArbFONTS',
                ),
              ),
              trailing: Icon(
                Icons.arrow_back_ios_new,
              ),
              leading: Icon(
                Icons.headset_mic_outlined,
                color: seconderyColor,
              )),
        ],
      ),
    );
  }
}

class Account extends StatelessWidget {
  const Account({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
              onTap: () {},
              title: Text(
                'حسابي',
                style: TextStyle(
                  fontFamily: 'ArbFONTS',
                ),
              ),
              subtitle: Text(
                '${FirebaseAuth.instance.currentUser?.email!}',
                style: TextStyle(
                  fontFamily: 'ArbFONTS',
                ),
              ),
              trailing: Icon(
                Icons.arrow_back_ios_new,
              ),
              leading: Icon(
                LineIcons.user,
                color: seconderyColor,
              )),
        ],
      ),
    );
  }
}

class Contact extends StatelessWidget {
  const Contact({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            onTap: () async {
              await launchUrl(Uri.parse('mailto:info@sedracare.com'));
            },
            title: Text(
              'ارسل لنا',
              style: TextStyle(
                fontFamily: 'ArbFONTS',
              ),
            ),
            subtitle: Text(
              'ارسل لنا على البريد الالكتروني',
              style: TextStyle(
                fontFamily: 'ArbFONTS',
              ),
            ),
            leading: Icon(
              Icons.email,
              color: seconderyColor,
            ),
            trailing: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          ListTile(
            onTap: () async {
              await launchUrl(
                  Uri.parse('mailto:youssefhussainnasr2000@gmail.com'));
            },
            title: Text(
              'تواصل مع المطور',
              style: TextStyle(
                fontFamily: 'ArbFONTS',
              ),
            ),
            subtitle: Text(
              'ارسل الى المطور على البريد الالكتروني',
              style: TextStyle(
                fontFamily: 'ArbFONTS',
              ),
            ),
            leading: Icon(
              Icons.engineering,
              color: seconderyColor,
            ),
            trailing: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          ListTile(
            onTap: () async {
              await launchUrl(Uri.parse('tel://+9660114170700'));
            },
            title: Text(
              'اتصل بنا',
              style: TextStyle(
                fontFamily: 'ArbFONTS',
              ),
            ),
            subtitle: Text(
              'اتصل بنا الآن',
              style: TextStyle(
                fontFamily: 'ArbFONTS',
              ),
            ),
            leading: Icon(
              LineIcons.phone,
              color: seconderyColor,
            ),
            trailing: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ],
      ),
    );
  }
}
