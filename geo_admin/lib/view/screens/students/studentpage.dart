// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../widget/studentmarks.dart';

class StudentPage extends StatelessWidget {
  final dynamic mdid;
  final dynamic name;
  final dynamic email;
  final dynamic imageurl;

  const StudentPage(
      {super.key,
      required this.mdid,
      required this.name,
      required this.email,
      required this.imageurl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        backgroundColor: mainColor,
        title: Text('Admin'),
      ),
      body: Center(
        child: StudentMarks(mdid: mdid),
      ),
    );
  }
}
