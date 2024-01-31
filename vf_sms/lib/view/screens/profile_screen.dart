import 'package:get/get.dart';
import 'package:vf_sms/main.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vf_sms/core/constants/colors.dart';
import 'package:vf_sms/view/screens/login_screen.dart';
// ignore_for_file: prefer_const_constructors

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  backgroundImage: AssetImage('assets/user-1.jpg'),
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
                    sharedPreferences!.clear();
                    Get.offAll(LoginScreen());
                  },
                  title: Text(
                    'Sign out',
                    style: TextStyle(
                      fontFamily: 'ArbFONTS',
                    ),
                  ),
                  subtitle: Text(
                    sharedPreferences!.getString('email')!,
                    style: TextStyle(
                      fontFamily: 'ArbFONTS',
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_back_ios_new,
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: secondryColor,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Privacy Policy . Term of use',
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
                await launchUrl(Uri.parse('tel://01205332630'));
              },
              title: Text(
                'Help',
                style: TextStyle(
                  fontFamily: 'ArbFONTS',
                ),
              ),
              subtitle: Text(
                'We can help you',
                style: TextStyle(
                  fontFamily: 'ArbFONTS',
                ),
              ),
              trailing: Icon(
                Icons.arrow_back_ios_new,
              ),
              leading: Icon(
                Icons.headset_mic_outlined,
                color: secondryColor,
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
                sharedPreferences!.getString('username')!,
                style: TextStyle(
                  fontFamily: 'ArbFONTS',
                ),
              ),
              subtitle: Text(
                sharedPreferences!.getString('email')!,
                style: TextStyle(
                  fontFamily: 'ArbFONTS',
                ),
              ),
              trailing: Icon(
                Icons.arrow_back_ios_new,
              ),
              leading: Icon(
                LineIcons.user,
                color: secondryColor,
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
              await launchUrl(
                  Uri.parse('mailto:youssefhussainnasr2000@gmail.com'));
            },
            title: Text(
              'Contact with Developer',
              style: TextStyle(
                fontFamily: 'ArbFONTS',
              ),
            ),
            subtitle: Text(
              'Send developer on G-mail',
              style: TextStyle(
                fontFamily: 'ArbFONTS',
              ),
            ),
            leading: Icon(
              Icons.engineering,
              color: secondryColor,
            ),
            trailing: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ],
      ),
    );
  }
}
