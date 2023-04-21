import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_login/screens/home/home_screen.dart';

class ChangePasswordController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  String? studentId;
  RxBool isOldPasswordVisible = true.obs;
  RxBool isNewPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;
  FocusNode focusNodeNewPassword = FocusNode();
  FocusNode focusNodeConNewPassword = FocusNode();
  RxBool isSubmitClicked = false.obs;

  @override
  void onInit() {
    studentIdSetPref();
    super.onInit();
  }

  oldPasswordValidator() {
    var pattern =
        (r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (oldPasswordController.text.isEmpty) {
      return 'This field is required';
    } else if (oldPasswordController.text.length < 8) {
      return 'Password should have atleast 8 characters';
    } else if (!RegExp(pattern).hasMatch(oldPasswordController.text)) {
      return 'Please enter a strong password';
    }
  }

  void studentIdSetPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    studentId = pref.getString('st_id');
  }

  newPasswordValidator() {
    var pattern =
        (r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (newPasswordController.text.isEmpty) {
      return 'This field is required';
    } else if (newPasswordController.text.length < 8) {
      return 'Password should have atleast 8 characters';
    } else if (!RegExp(pattern).hasMatch(newPasswordController.text)) {
      return 'Please enter a strong password';
    }
  }

  confirmPasswordValidator() {
    var pattern =
        (r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (confirmNewPasswordController.text.isEmpty) {
      return 'This field is required';
    } else if (confirmNewPasswordController.text.length < 8) {
      return 'Password should have atleast 8 characters';
    } else if (!RegExp(pattern).hasMatch(confirmNewPasswordController.text)) {
      return 'Please enter a strong password';
    } else if (newPasswordController.text !=
        confirmNewPasswordController.text) {
      return 'Please enter same password';
    }
  }

  void onSubmit() {
    print('object');
    if (!formKey.currentState!.validate()) {
      print('done');
      return;
    }
    changePasswordApi();
  }

  void changePasswordApi() async {
    final Uri uri = Uri.parse(
        'https://akashsir.in/myapi/ecom1/api/api-change-password.php');
    final Map body = {
      'user_id': studentId,
      'opass': oldPasswordController.text,
      'npass': newPasswordController.text,
      'cpass': confirmNewPasswordController.text
    };
    final response = await http.post(uri, body: body);
    print(response.statusCode);
    print(response.body);

    final json = jsonDecode(response.body);
    final int flag = int.parse(json['flag']);

    if (response.statusCode == 200 && flag == 1) {
      isSubmitClicked.value = true;
      await Future.delayed(const Duration(seconds: 1));

      Get.snackbar(json['message'], '', duration: const Duration(seconds: 3));
      Get.offNamed(HomeScreen.routeName);
    } else {
      isSubmitClicked.value = true;
      await Future.delayed(const Duration(seconds: 1));

      Get.snackbar(json['message'], '', duration: const Duration(seconds: 3));
    }
    isSubmitClicked.value = false;
  }

  @override
  void onClose() {
    focusNodeConNewPassword.dispose();
    focusNodeNewPassword.dispose();
    super.onClose();
  }
}
