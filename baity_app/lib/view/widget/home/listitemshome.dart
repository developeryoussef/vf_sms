import 'package:get/get.dart';
import '../../../linkapi.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../core/constant/color.dart';
import 'package:line_icons/line_icons.dart';
import '../../../data/model/itemsmodel.dart';
import '../../../controller/home_controller.dart';
// ignore_for_file: prefer_typing_uninitialized_variables, unused_import, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_brace_in_string_interps

class ListItemsHome extends GetView<HomeControllerImp> {
  const ListItemsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
          itemCount: controller.items.length,
          itemBuilder: (context, i) {
            return ItemsHome(
                itemsModel: ItemsModel.fromJson(controller.items[i]));
          }),
    );
  }
}

class ItemsHome extends StatelessWidget {
  final ItemsModel itemsModel;
  const ItemsHome({Key? key, required this.itemsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/1.png')),
                    ),
                  ),
                )),
            SizedBox(
              width: 5,
            ),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            itemsModel.itemsName!.toString(),
                            style: TextStyle(
                              color: AppColor.secondColor,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'ArbFONTS',
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            itemsModel.itemsDesc.toString(),
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'ArbFONTS',
                            ),
                          ),
                          Text(
                            itemsModel.itemsPrice.toString(),
                            style: TextStyle(
                              color: Color.fromARGB(255, 224, 84, 124),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'ArbFONTS',
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Center(
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              itemsModel.isFavorite == true
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_outline_rounded,
                              color: AppColor.primaryColor,
                            )),
                      ),
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Icon(
                              LineIcons.addToShoppingCart,
                              color: Colors.white,
                            ),
                          ),
                          Center(
                            child: Text(
                              'Add',
                              style: TextStyle(
                                  fontFamily: 'ArbFONTS',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                      height: 90,
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                    ))),
          ],
        ),
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
