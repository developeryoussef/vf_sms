import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rewayat_alkateb_islam/constants.dart';

import 'package:rewayat_alkateb_islam/views/widgets/fbLoginButton.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('التسجيل',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Cairo'),),centerTitle: true,
        brightness: Brightness.dark,backgroundColor: kMainColor,
      ),
      body: Container(
        child: Center(
          child: buildFacebookLoginButton(context),
        ),
      ),
    );
  }
}
