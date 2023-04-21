import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_login/screens/home/home_screen.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  RxBool isLoginClicked = false.obs;
  RxBool isPasswordVisible = true.obs;

  String? loginEmailValidator() {
    if (emailController.text.isEmpty) {
      return 'This field is required';
    } else if (!RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(emailController.text)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? loginPasswordValidator() {
    var pattern =
        (r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (passwordController.text.isEmpty) {
      return 'This field is required';
    } else if (passwordController.text.length < 8) {
      return 'Password should have atleast 8 characters';
    } else if (!RegExp(pattern).hasMatch(passwordController.text)) {
      return 'Please enter a strong password';
    }
    return null;
  }

  void onLogin() {
    print('object');
    if (!loginFormKey.currentState!.validate()) {
      print('done');
      return;
    }
    loginApi();
  }

  void loginApi() async {
    final Uri uri =
        Uri.parse('https://akashsir.in/myapi/ecom1/api/api-login.php');
    final Map body = {
      'user_email': emailController.text,
      'user_password': passwordController.text
    };

    final response = await http.post(uri, body: body);
    print(response.statusCode);
    print(response.body);

    final json = jsonDecode(response.body);
    final int flag = int.parse(json['flag']);

    SharedPreferences pref = await SharedPreferences.getInstance();

    if (response.statusCode == 200 && flag == 1) {
      pref.setBool('isLogin', true);
      pref.setString('user_id', json['user_id']);

      isLoginClicked.value = true;
      await Future.delayed(const Duration(seconds: 1));
      Get.snackbar(json['message'], '', duration: const Duration(seconds: 3));

      Get.offNamed(HomeScreen.routeName)?.then(
        (value) {
          emailController.clear();
          passwordController.clear();
        },
      );
    } else {
      isLoginClicked.value = true;
      await Future.delayed(const Duration(seconds: 1));

      Get.snackbar(json['message'], '', duration: const Duration(seconds: 3));
    }
    isLoginClicked.value = false;
  }
}
