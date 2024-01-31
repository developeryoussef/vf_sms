// ignore_for_file: unnecessary_this

class CategoriesModel {
  String? categoriesId;
  String? categoriesName;

  CategoriesModel({
    this.categoriesId,
    this.categoriesName,
  });

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    categoriesId = json['_id'];
    categoriesName = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.categoriesId;
    data['name'] = this.categoriesName;
    return data;
  }
}
