import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:user_login/screens/login/login_screen.dart';

class ForgotPasswordController extends GetxController {
  GlobalKey<FormState> cpformKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  RxBool isForgotSubmitClicked = false.obs;

  emailValidator() {
    if (emailController.text.isEmpty) {
      return 'This field is required';
    } else if (!RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(emailController.text)) {
      return 'Please enter a valid email';
    }
  }

  void onSubmit() {
    print('object');
    if (!cpformKey.currentState!.validate()) {
      print('done');
      return;
    }
    forgotPasswordApi();
  }

  void forgotPasswordApi() async {
    final Uri uri = Uri.parse(
        'https://akashsir.in/myapi/crud/student-forgot-password-api.php');
    final Map body = {'st_email': emailController.text};
    final response = await http.post(uri, body: body);
    print(response.statusCode);
    print(response.body);

    final json = jsonDecode(response.body);
    final int flag = int.parse(json['flag']);

    if (response.statusCode == 200 && flag == 1) {
      isForgotSubmitClicked.value = true;
      await Future.delayed(const Duration(seconds: 1));

      // Get.offNamed(LoginScreen.routeName);
      Get.back();
      Get.snackbar(json['message'], '', duration: const Duration(seconds: 4));
    } else {
      isForgotSubmitClicked.value = true;
      await Future.delayed(const Duration(seconds: 1));

      Get.snackbar(json['message'], '', duration: const Duration(seconds: 3));
    }
    isForgotSubmitClicked.value = false;
  }
}
