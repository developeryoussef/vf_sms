import 'package:get/get.dart';
import '../core/constant/routes.dart';
import '../data/model/itemsmodel.dart';
import 'package:flutter/cupertino.dart';
import '../core/services/services.dart';
import '../core/class/statusrequest.dart';
import '../data/model/categoriesmodel.dart';
import '../data/datasource/remote/home_data.dart';
import '../data/datasource/remote/home_data.dart';
import '../core/functions/handingdatacontroller.dart';
// ignore_for_file: duplicate_import

abstract class HomeController extends SearchMixController {
  initialData();
  getCategoriesdata();
  getProductsdata();
  getCategData(CategoriesModel model);
  // goToItems(List categories, int selectedCat, String categoryid);
}

class HomeControllerImp extends HomeController {
  MyServices myServices = Get.find();

  CategoriesModel? selectedCateg;

  String? username;
  String? id;
  String? lang;

  HomeData homedata = HomeData(Get.find());

  // List data = [];
  List categories = [];
  List items = [];
  List categItems = [];
  // List items = [];

  @override
  initialData() {
    // myServices.sharedPreferences.clear() ;
    lang = myServices.sharedPreferences.getString("lang");
    username = myServices.sharedPreferences.getString("username");
    id = myServices.sharedPreferences.getString("id");
  }

  @override
  void onInit() {
    search = TextEditingController();
    getCategoriesdata();
    getProductsdata();
    initialData();
    update();
    super.onInit();
  }

  @override
  getCategoriesdata() async {
    statusRequest = StatusRequest.loading;
    var response = await homedata.getCategoriesData();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      categories.addAll(response);
      update();
    } else {
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  @override
  getProductsdata() async {
    statusRequest = StatusRequest.loading;
    var response = await homedata.getProductsData();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      items.addAll(response);
      update();
    } else {
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  @override
  getCategData(CategoriesModel model) async {
    statusRequest = StatusRequest.loading;
    var response = await homedata.getCategItemsData(model.categoriesId!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      categItems.addAll(response);
      update();
    } else {
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  // @override
  // goToItems(categories, selectedCat, categoryid) {
  //   Get.toNamed(AppRoute.items, arguments: {
  //     "categories": categories,
  //     "selectedcat": selectedCat,
  //     "catid": categoryid
  //   });
  // }

  goToPageProductDetails(itemsModel) {
    Get.toNamed("productdetails", arguments: {"itemsmodel": itemsModel});
  }
}

class SearchMixController extends GetxController {
  List<ItemsModel> listdata = [];

  late StatusRequest statusRequest;
  HomeData homedata = HomeData(Get.find());

  searchData() async {
    statusRequest = StatusRequest.loading;
    var response = await homedata.searchData(search!.text);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        listdata.clear();
        List responsedata = response['data'];
        listdata.addAll(responsedata.map((e) => ItemsModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  bool isSearch = false;
  TextEditingController? search;
  checkSearch(val) {
    if (val == "") {
      statusRequest = StatusRequest.none;
      isSearch = false;
    }
    update();
  }

  onSearchItems() {
    isSearch = true;
    searchData();
    update();
  }
}
