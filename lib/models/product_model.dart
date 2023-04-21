class ProductModel {
  String? flag;
  String? message;
  String? title;
  List<ProductList>? productList;

  ProductModel({this.flag, this.message, this.title, this.productList});

  ProductModel.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    message = json['message'];
    title = json['title'];
    if (json['product_list'] != null) {
      productList = <ProductList>[];
      json['product_list'].forEach((v) {
        productList!.add(ProductList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flag'] = flag;
    data['message'] = message;
    data['title'] = title;
    if (productList != null) {
      data['product_list'] = productList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductList {
  String? productId;
  String? productName;
  String? productDetails;
  String? productPrice;
  String? productImage;
  String? productQuantity;
  String? subCategoryName;
  String? subCategoryId;
  String? isProductInCart;

  ProductList(
      {this.productId,
      this.productName,
      this.productDetails,
      this.productPrice,
      this.productImage,
      this.productQuantity,
      this.subCategoryName,
      this.subCategoryId,
      this.isProductInCart});

  ProductList.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productDetails = json['product_details'];
    productPrice = json['product_price'];
    productImage = json['product_image'];
    productQuantity = json['product_quantity'];
    subCategoryName = json['sub_category_name'];
    subCategoryId = json['sub_category_id'];
    isProductInCart = json['is_product_in_cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_details'] = productDetails;
    data['product_price'] = productPrice;
    data['product_image'] = productImage;
    data['product_quantity'] = productQuantity;
    data['sub_category_name'] = subCategoryName;
    data['sub_category_id'] = subCategoryId;
    data['is_product_in_cart'] = isProductInCart;
    return data;
  }
}
