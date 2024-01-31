import 'package:get/get.dart';
import '../../../linkapi.dart';
import 'package:flutter/material.dart';
import '../../../core/constant/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../controller/home_controller.dart';
import '../../../data/model/categoriesmodel.dart';
import 'package:baity_app/core/constant/routes.dart';
import '../../../core/functions/translatefatabase.dart';
// ignore_for_file: avoid_print

// ignore_for_file: unnecessary_null_comparison

class ListCategoriesHome extends GetView<HomeControllerImp> {
  const ListCategoriesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: controller.categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Categories(
            i: index,
            categoriesModel:
                CategoriesModel.fromJson(controller.categories[index]),
          );
        },
      ),
    );
  }
}

class Categories extends GetView<HomeControllerImp> {
  final CategoriesModel categoriesModel;
  final int? i;
  const Categories({Key? key, required this.categoriesModel, required this.i})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.selectedCateg = categoriesModel;
        controller.categItems = controller.items
            .where((element) => element['_id'] == categoriesModel.categoriesId)
            .toList();
        print("categsI ${controller.categItems}");
        // if (categoriesModel != null) {
        //   Get.toNamed(AppRoute.categItems);
        // }
      },
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Center(
                child: Text(
                  "${categoriesModel.categoriesName}",
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontFamily: 'ArbFONTS'),
                ),
              )),
        ],
      ),
    );
  }
}
