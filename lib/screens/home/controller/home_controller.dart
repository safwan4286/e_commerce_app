import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:user_login/models/category_model.dart';
import 'package:user_login/models/product_model.dart';

import '../../../models/banner_list_model.dart';

class HomeController extends GetxController {
  String? studentId;
  Rx<CategoryModel> categoryModel = CategoryModel().obs;
  Rx<ProductModel> productModel = ProductModel().obs;
  Rx<BannerListModel> bannerListModel = BannerListModel().obs;
  RxBool isCategoryLoading = false.obs;
  RxInt selectedIndex = 0.obs;
  RxString categoryId = '1'.obs;
  // final CarouselController _carouselController = CarouselController();

  @override
  void onInit() {
    bannerListApi();
    categoryApi();
    productApi();
    super.onInit();
  }

  void categoryById(String id) {
    categoryId.value = id;
  }

  List<ProductList>? get selectedProduct {
    return productModel.value.productList?.where(
      (element) {
        return element.subCategoryId == categoryId.value;
      },
    ).toList();
  }

  // List<ProductList>? get productListById {
  //   return productModel.value.productList?.where((element) {
  //     return element.subCategoryId==categoryId.value;
  //   }).toList();
  // };

  void logOutSetPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isLogin', false);
  }

  void categoryApi() async {
    final Uri uri = Uri.parse(
        'https://akashsir.in/myapi/ecom1/api/api-subcategory-list.php');

    isCategoryLoading.value = true;

    final response = await http.get(uri);
    print(response.statusCode);
    print(response.body);
    final json = jsonDecode(response.body);
    int flag = int.parse(json['flag']);
    if (response.statusCode == 200 && flag == 1) {
      await Future.delayed(const Duration(seconds: 1));

      categoryModel.value = CategoryModel.fromJson(json);
    } else {
      await Future.delayed(const Duration(seconds: 1));
      isCategoryLoading.value = true;

      Get.snackbar(json['message'], '');
    }
    isCategoryLoading.value = false;
  }

  void productApi() async {
    final Uri uri =
        Uri.parse('https://akashsir.in/myapi/ecom1/api/api-view-product.php');
    final response = await http.get(uri);
    print(response.statusCode);
    print(response.body);
    final json = jsonDecode(response.body);
    int flag = int.parse(json['flag']);
    if (response.statusCode == 200 && flag == 1) {
      await Future.delayed(const Duration(seconds: 1));
      isCategoryLoading.value = true;

      productModel.value = ProductModel.fromJson(json);
    } else {
      await Future.delayed(const Duration(seconds: 1));
      isCategoryLoading.value = true;

      Get.snackbar(json['message'], '');
    }
    isCategoryLoading.value = false;
  }

  void bannerListApi() async {
    final Uri uri =
        Uri.parse('https://akashsir.in/myapi/ecom1/api/api-banner-list.php');
    final response = await http.get(uri);
    print(response.statusCode);
    print(response.body);
    final json = jsonDecode(response.body);
    int flag = int.parse(json['flag']);
    if (response.statusCode == 200 && flag == 1) {
      bannerListModel.value = BannerListModel.fromJson(json);
    } else {
      // await Future.delayed(const Duration(seconds: 1));

      Get.snackbar(json['message'], '');
    }
  }
}
