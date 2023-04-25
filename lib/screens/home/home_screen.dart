import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_login/screens/home/controller/home_controller.dart';
import 'package:user_login/screens/change_password/change_password_screen.dart';
import 'package:user_login/screens/home/widgets/banner_widget.dart';
import 'package:user_login/screens/home/widgets/category_list_widget.dart';
import 'package:user_login/screens/home/widgets/product_list_widget.dart';
import 'package:user_login/widgets/my_title_text_widget.dart';

import '../login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static const routeName = '/home_screen';
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade50,
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        drawer: Drawer(
          child: ListView(padding: const EdgeInsets.only(top: 100), children: [
            TextButton(
                onPressed: () {
                  Get.toNamed(ChangePasswordScreen.routeName,
                      arguments: homeController.studentId);
                },
                child: const Text('Change Password')),
            TextButton(
                onPressed: () {
                  homeController.logOutSetPref();
                  Get.offAllNamed(LoginScreen.routeName);
                },
                child: const Text('Log Out'))
          ]),
        ),
        body: Obx(() => homeController.isCategoryLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: ListView(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    BannerWidget(
                        bannerListModel: homeController.bannerListModel),
                    Container(
                        padding: const EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: const MyTitleTextWidget(
                            text: 'Categories', color: Colors.blue)),
                    Obx(() => CategoryListWidget(
                        homeController: homeController,
                        selectedIndex: homeController.selectedIndex,
                        categoryModel: homeController.categoryModel.value)),
                    Container(
                        padding: const EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: const MyTitleTextWidget(
                          text: 'Products',
                          color: Colors.blue,
                        )),
                    Obx(() => ProductListWidget(
                          homeController: homeController,
                          productList: homeController.selectedProduct,
                        )),
                  ],
                ),
              )));
  }
}
