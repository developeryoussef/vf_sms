import 'package:get/get.dart';
import '../../../linkapi.dart';
import '../widget/customappbar.dart';
import 'package:flutter/material.dart';
import '../widget/home/listitemshome.dart';
import '../../../core/constant/routes.dart';
import '../widget/home/customcardhome.dart';
import '../../../data/model/itemsmodel.dart';
import '../widget/home/customtitlehome.dart';
import '../widget/home/listcategorieshome.dart';
import '../../../controller/home_controller.dart';
import '../../../core/class/handlingdataview.dart';
import 'package:baity_app/core/constant/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
// ignore_for_file: unused_import

// ignore_for_file: prefer_const_constructors

class CategoryItemsScreen extends StatelessWidget {
  const CategoryItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    return GetBuilder<HomeControllerImp>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.primaryColor,
            elevation: 0,
            title: Text('${controller.selectedCateg!.categoriesName}'),
          ),
          body: ListView.builder(
            itemBuilder: (context, index) {
              return Container();
            },
          ),
        );
      },
    );
  }
}
