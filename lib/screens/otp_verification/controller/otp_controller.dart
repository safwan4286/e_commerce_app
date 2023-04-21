import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:user_login/screens/home/home_screen.dart';

class OtpController extends GetxController {
  final TextEditingController otpInputController = TextEditingController();
  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  String? mobileNumber;
  RxBool isResendClicked = false.obs;
  RxBool isSubmitOtpClicked = false.obs;

  @override
  void onInit() {
    mobileNumber = Get.arguments as String;
    super.onInit();
  }

  onOtpSubmit() {
    if (!otpFormKey.currentState!.validate()) {
      print('done');
      return;
    }
    otpVerificationApi();
  }

  void otpVerificationApi() async {
    final Uri uri =
        Uri.parse('https://akashsir.in/myapi/crud/verify-mobile-otp.php');
    final Map body = {
      'mobile_otp': otpInputController.text,
      'st_mobileno': mobileNumber,
    };
    final response = await http.post(uri, body: body);
    print(response.statusCode);
    print(response.body);
    final json = jsonDecode(response.body);

    final int flag = int.parse(json['flag']);
    if (response.statusCode == 200 && flag == 1) {
      isSubmitOtpClicked.value = true;
      await Future.delayed(const Duration(seconds: 1));

      Get.snackbar(json['message'], '', duration: const Duration(seconds: 3));
      Get.offAllNamed(
        HomeScreen.routeName,
        arguments: json['st_id'],
      );
    } else {
      isSubmitOtpClicked.value = true;
      await Future.delayed(const Duration(seconds: 1));

      Get.snackbar(json['message'], '', duration: const Duration(seconds: 3));
    }
    isSubmitOtpClicked.value = false;
  }

  void resendOtpApi() async {
    final Uri uri =
        Uri.parse('https://akashsir.in/myapi/crud/resend-mobile-otp.php');
    final Map body = {'st_mobileno': mobileNumber};
    final response = await http.post(uri, body: body);
    print(response.statusCode);
    print(response.body);
    final json = jsonDecode(response.body);
    final int flag = int.parse(json['flag']);
    if (response.statusCode == 200 && flag == 1) {
      Get.snackbar(json['message'], json['mobile_otp'],
          duration: const Duration(seconds: 5));
      isResendClicked.value = true;
    } else {
      Get.snackbar(json['message'], '', duration: const Duration(seconds: 3));
    }
    await Future.delayed(const Duration(seconds: 10));
    isResendClicked.value = false;
  }
}
