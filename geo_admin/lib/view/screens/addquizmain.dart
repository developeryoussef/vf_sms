// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import, avoid_print, body_might_complete_normally_nullable, unnecessary_brace_in_string_interps, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import 'quizpage.dart';

class AddQuizPage extends StatelessWidget {
  const AddQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: itGrey,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(17),
                child: Image.asset('assets/Picture1.png'),
              ),
              Text(
                'Tap the add button to create new quiz',
                style: TextStyle(fontSize: 16.5),
              ),
              SizedBox(
                height: 50,
              ),
              MaterialButton(
                child: Container(
                  child: Center(child: Text('Add New Quiz')),
                  height: 60,
                  width: Get.width - 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black87)),
                ),
                onPressed: () {
                  Get.bottomSheet(Container(
                    width: double.infinity,
                    height: Get.height / 4,
                    color: itGrey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            trailing: Icon(Icons.arrow_forward_ios_rounded),
                            onTap: () => Get.off(QuizPage(
                              path: 'quizpapers',
                              primary: 'Senior 1',
                            )),
                            title: Text(
                              'Senior 1',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ListTile(
                            trailing: Icon(Icons.arrow_forward_ios_rounded),
                            onTap: () => Get.off(QuizPage(
                              path: 'quizpapers',
                              primary: 'Senior 2',
                            )),
                            title: Text(
                              'Senior 2',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ListTile(
                            trailing: Icon(Icons.arrow_forward_ios_rounded),
                            onTap: () => Get.off(QuizPage(
                              path: 'quizpapers',
                              primary: 'Senior 3',
                            )),
                            title: Text(
                              'Senior 3',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
                },
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
