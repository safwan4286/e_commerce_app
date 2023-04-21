import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_login/screens/otp_verification/controller/otp_controller.dart';
import 'package:user_login/widgets/my_button_widget.dart';
import 'package:user_login/widgets/my_textformfield.dart';
import 'package:user_login/widgets/my_title_text_widget.dart';
import 'package:get/get.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({super.key});
  static const routeName = '/otp_verification';
  OtpController otpController = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: otpController.otpFormKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              Image.asset('assets/images/otp_image.png'),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              const MyTitleTextWidget(text: 'Enter OTP', color: Colors.black),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              MyTextFormFieldWidget(
                controller: otpController.otpInputController,
                lebelText: 'OTP',
                keybordType: TextInputType.number,
                textInputAction: TextInputAction.done,
                icon: Icons.key,
                textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
                functoin: (value) {
                  if (value!.isEmpty) {
                    return 'This field is required';
                  }
                },
                maxlength: 4,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Obx(() => InkWell(
                    onTap: () {
                      otpController.onOtpSubmit();
                    },
                    child: MyButtonWidget(
                        isButtonClicked: otpController.isSubmitOtpClicked.value,
                        text: 'Submit',
                        buttonColor: Colors.blue,
                        textColor: Colors.white),
                  )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Obx(() => TextButton(
                  onPressed: otpController.isResendClicked.value
                      ? () {
                          return;
                        }
                      : () {
                          otpController.resendOtpApi();
                        },
                  child: Text(
                    'Resend OTP',
                    style: TextStyle(
                        color: otpController.isResendClicked.value
                            ? Colors.grey
                            : Colors.blue),
                  )))
            ],
          ),
        ),
      ),
    );
  }
}
