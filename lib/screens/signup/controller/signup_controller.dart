import 'dart:convert';
import '../../otp_verification/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isSignupClicked = false.obs;
  RxBool isPasswordVisible = true.obs;
  RxString genderType = ''.obs;
  RxString genderValidator = ''.obs;
  FocusNode addressFocus = FocusNode();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  emailValidator() {
    if (emailController.text.isEmpty) {
      return 'This field is required';
    } else if (!RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(emailController.text)) {
      return 'Please enter a valid email';
    }
  }

  nameValidator() {
    if (nameController.text.isEmpty) {
      return 'This field is required';
    } else if (nameController.text.length < 3) {
      return 'Name must be 3 or more characters';
    }
  }

  addressValidator() {
    if (addressController.text.isEmpty) {
      return 'This field is required';
    } else if (addressController.text.length < 3) {
      return 'enter full address';
    }
  }

  phoneValidator() {
    var pattern = (r'^(?:[+0]9)?[0-9]{10}$');

    if (phoneController.text.isEmpty) {
      return 'This field is required';
    } else if (!RegExp(pattern).hasMatch(phoneController.text)) {
      return 'Please enter a valid phone number';
    }
  }

  passwordValidator() {
    var pattern =
        (r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (passwordController.text.isEmpty) {
      return 'This field is required';
    } else if (passwordController.text.length < 8) {
      return 'Password should have atleast 8 characters';
    } else if (!RegExp(pattern).hasMatch(passwordController.text)) {
      return 'Please enter a strong password';
    }
  }

  // gebderValidator() {
  //   if (genderController.text.isEmpty) {
  //     return 'This field is required';
  //   } else if (genderController.text != 'male' &&
  //       genderController.text != 'female' &&
  //       genderController.text != 'Male' &&
  //       genderController.text != 'Female') {
  //     return 'Enter Male or Female';
  //   }
  // }

  void onSignup() {
    print('object');
    if (!signupFormKey.currentState!.validate()) {
      print('done');
      return;
    }
    signupApi();
  }

  void signupApi() async {
    final Uri uri =
        Uri.parse('https://akashsir.in/myapi/ecom1/api/api-signup.php');
    final Map body = {
      'user_mobile': phoneController.text,
      'user_name': nameController.text,
      'user_gender': genderType.value,
      'user_password': passwordController.text,
      'user_email': emailController.text,
      'user_address': addressController.text,
    };
    final response = await http.post(uri, body: body);
    print(response.statusCode);
    print(response.body);
    final json = jsonDecode(response.body);

    final int flag = int.parse(json['flag']);
    if (response.statusCode == 200 && flag == 1) {
      isSignupClicked.value = true;
      await Future.delayed(const Duration(seconds: 1));
      // otpApi();
      Get.back();
      Get.snackbar(json['message'], '', duration: const Duration(seconds: 3));
    } else {
      isSignupClicked.value = true;
      await Future.delayed(const Duration(seconds: 1));
      Get.snackbar(json['message'], '', duration: const Duration(seconds: 3));
    }
    isSignupClicked.value = false;
  }

  void otpApi() async {
    final Uri uri =
        Uri.parse('https://akashsir.in/myapi/crud/login-with-otp.php');
    final Map body = {
      'st_mobileno': phoneController.text,
      'st_name': nameController.text,
    };
    final response = await http.post(uri, body: body);
    print(response.statusCode);
    print(response.body);
    final json = jsonDecode(response.body);

    final int flag = int.parse(json['flag']);
    if (response.statusCode == 200 && flag == 1) {
      Get.offAllNamed(OtpVerificationScreen.routeName,
          arguments: json['st_mobileno']);
      Get.snackbar(json['message'], json['mobile_otp'],
          duration: const Duration(seconds: 4));
    } else {
      Get.snackbar('', json['message'], duration: const Duration(seconds: 3));
    }
  }

  @override
  void onClose() {
    addressFocus.dispose();
    super.onClose();
  }
}
