// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import 'studentpage.dart';

class MainStudentsPage extends StatelessWidget {
  const MainStudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                'Student rank',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: itRed,
                      ),
                    );
                  }

                  return ListView(
                    physics: BouncingScrollPhysics(),
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      var name = data['name'];
                      var email = data['email'];
                      var imageurl = data['profilepic'];
                      var mdid = document.id;

                      return ListTile(
                        onTap: () {
                          Get.to(
                            StudentPage(
                              mdid: mdid,
                              email: email,
                              name: name,
                              imageurl: imageurl,
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 25,
                          backgroundImage: NetworkImage(imageurl.toString()),
                        ),
                        title: Text(name.toString()),
                        subtitle: Text(email.toString()),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
