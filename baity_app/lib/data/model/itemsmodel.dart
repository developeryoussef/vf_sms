// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class ItemsModel {
  String? itemsId;
  String? itemsName;
  String? itemsDesc;
  String? itemsImage;
  int? itemsCount;
  bool? isFavorite;
  int? itemsPrice;

  String? itemsCat;

  ItemsModel({
    this.itemsId,
    this.itemsName,
    this.itemsDesc,
    this.itemsImage,
    this.itemsCount,
    this.itemsPrice,
    this.isFavorite = false,
    this.itemsCat,
  });

  ItemsModel.fromJson(Map<String, dynamic> json) {
    itemsId = json['_id'];
    itemsName = json['name'];
    itemsDesc = json['description'];
    itemsImage = json['imageurl'];
    itemsCount = json['productcount'];
    itemsPrice = json['price'];
    itemsCat = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.itemsId;
    data['name'] = this.itemsName;
    data['description'] = this.itemsDesc;
    data['items_image'] = this.itemsImage;
    data['items_count'] = this.itemsCount;
    data['items_price'] = this.itemsPrice;
    data['items_cat'] = this.itemsCat;
    return data;
  }
}
