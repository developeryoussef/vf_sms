// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import, avoid_print, body_might_complete_normally_nullable, unnecessary_brace_in_string_interps, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../main.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 85,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/Picture1.png'),
              ),
              Text(
                'Signora Sara',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                    fontSize: 25,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                'signorasara@gmail.com',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
              ),
              //
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 40,
                child: Text(
                  'SETTINGS',
                  style: TextStyle(
                      letterSpacing: 1.5,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                color: Color.fromARGB(255, 220, 220, 220),
              ),
              ListTile(
                leading: Icon(
                  Icons.flag_outlined,
                  color: Colors.black87,
                  size: 30,
                ),
                subtitle: Text(
                  'Egypt',
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w500),
                ),
                title: Text(
                  'Country',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.bottomSheet(Container(
                    color: itGrey,
                    width: Get.width,
                    height: Get.height / 5,
                    child: ListTile(
                      onTap: () {
                        sharedPreferences!.getString('term') == 'firsterm'
                            ? sharedPreferences!.setString('term', 'secondterm')
                            : sharedPreferences!.setString('term', 'firsterm');
                      },
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      title: Text(
                        sharedPreferences!.getString('term') == 'firsterm'
                            ? 'Scecond term'
                            : 'First Term',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ));
                },
                leading: Icon(
                  Icons.alarm_outlined,
                  color: Colors.black87,
                  size: 30,
                ),
                subtitle: Text(
                  sharedPreferences!.getString('term') != 'firsterm'
                      ? 'Scecond term'
                      : 'First Term',
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w500),
                ),
                title: Text(
                  'Term',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
