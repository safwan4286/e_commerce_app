class CategoryModel {
  String? flag;
  String? message;
  String? title;
  List<SubCategoryList>? subCategoryList;

  CategoryModel({this.flag, this.message, this.title, this.subCategoryList});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    message = json['message'];
    title = json['title'];
    if (json['sub_category_list'] != null) {
      subCategoryList = <SubCategoryList>[];
      json['sub_category_list'].forEach((v) {
        subCategoryList!.add(SubCategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flag'] = flag;
    data['message'] = message;
    data['title'] = title;
    if (subCategoryList != null) {
      data['sub_category_list'] =
          subCategoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategoryList {
  String? subCategoryId;
  String? subCategoryName;
  String? categoryId;
  String? categoryName;
  String? subCategoryImage;

  SubCategoryList(
      {this.subCategoryId,
      this.subCategoryName,
      this.categoryId,
      this.categoryName,
      this.subCategoryImage});

  SubCategoryList.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['sub_category_id'];
    subCategoryName = json['sub_category_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    subCategoryImage = json['sub_category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_category_id'] = subCategoryId;
    data['sub_category_name'] = subCategoryName;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['sub_category_image'] = subCategoryImage;
    return data;
  }
}
