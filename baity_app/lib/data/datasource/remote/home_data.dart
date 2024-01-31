import '../../../../linkapi.dart';
import '../../../../core/class/crud.dart';

class HomeData {
  Crud crud;
  HomeData(this.crud);
  getCategoriesData() async {
    var response = await crud.postData(AppLink.categories, {});
    return response.fold((l) => l, (r) => r);
  }

  getProductsData() async {
    var response = await crud.postData(AppLink.products, {});
    return response.fold((l) => l, (r) => r);
  }

  getCategItemsData(String id) async {
    var response = await crud.postData(AppLink.categProducts, {
      "id": id,
    });
    return response.fold((l) => l, (r) => r);
  }

  searchData(String search) async {
    var response = await crud.postData(AppLink.searchitems, {"search": search});
    return response.fold((l) => l, (r) => r);
  }
}
