import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OfflinePage extends StatefulWidget {
  const OfflinePage({Key? key}) : super(key: key);

  @override
  _OfflinePageState createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("check your internet connection"),
        ),
      ),
    );
  }
}//https://stackoverflow.com/a/56959146/14274728