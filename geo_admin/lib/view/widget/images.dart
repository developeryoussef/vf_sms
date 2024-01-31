// ignore_for_file: file_names, unused_import, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/cupertino.dart';

class ImageofonBoarding extends StatelessWidget {
  final String? imageUrl;
  ImageofonBoarding({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.asset(width: 260, height: 260, '$imageUrl');
  }
}
