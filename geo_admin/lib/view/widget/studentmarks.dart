// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import, avoid_print, body_might_complete_normally_nullable, unnecessary_brace_in_string_interps, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';

class StudentMarks extends StatelessWidget {
  final dynamic mdid;
  const StudentMarks({super.key, required this.mdid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('students')
          .doc(mdid)
          .collection('smarks')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;

            List marks = data['marks'];
            print(marks);
            print(marks.length);

            return Container(
              height: 600,
              child: MarksViewer(marks: marks),
            );
          }).toList(),
        );
      },
    );
  }
}

class MarksViewer extends StatelessWidget {
  final List marks;
  const MarksViewer({super.key, required this.marks});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${marks[index]}'),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 1,
            color: itGrey,
          );
        },
        itemCount: marks.length,
      ),
    );
  }
}
