import 'package:flutter/material.dart';

import '../../main.dart';

class CustonTextFormAuth extends StatelessWidget {
  final String hinttext;
  final String labeltext;
  final IconData iconData;
  final TextEditingController? mycontroller;
  final TextInputType? type;

  const CustonTextFormAuth(
      {Key? key,
      required this.hinttext,
      required this.labeltext,
      required this.iconData,
      required this.mycontroller,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: mycontroller,
        cursorColor: mainColor,
        keyboardType: type,
        decoration: InputDecoration(
            focusColor: mainColor,
            hoverColor: mainColor,
            floatingLabelStyle: TextStyle(color: mainColor),
            fillColor: itGrey,
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            hintText: hinttext,
            hintStyle: const TextStyle(fontSize: 14),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: Text(labeltext)),
            suffixIcon: Icon(
              iconData,
              color: mainColor,
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: mainColor,
                  width: 10,
                ),
                borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}

class CustomQuizesTextField extends StatelessWidget {
  final String hinttext;
  final TextEditingController? mycontroller;
  final TextInputType? type;
  final String? suffix;

  const CustomQuizesTextField(
      {Key? key,
      required this.hinttext,
      required this.mycontroller,
      required this.suffix,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: mycontroller,
        maxLines: null,
        minLines: null,
        cursorColor: mainColor,
        keyboardType: type,
        decoration: InputDecoration(
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            focusColor: mainColor,
            hoverColor: mainColor,
            floatingLabelStyle: TextStyle(color: mainColor),
            fillColor: itGrey,
            hintText: hinttext,
            hintStyle: const TextStyle(fontSize: 14),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}
