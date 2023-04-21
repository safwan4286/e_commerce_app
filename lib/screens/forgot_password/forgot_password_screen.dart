import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_login/screens/forgot_password/controller/forget_password_controller.dart';
import 'package:user_login/widgets/my_button_widget.dart';
import 'package:user_login/widgets/my_textformfield.dart';
import 'package:user_login/widgets/my_title_text_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  static const routeName = '/change_password_screen';
  ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: forgotPasswordController.cpformKey,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              children: [
                IconButton(
                    alignment: Alignment.centerLeft,
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Image.asset('assets/images/forgot_image.png'),
                const MyTitleTextWidget(
                  text: 'Forgot',
                  color: Colors.black,
                ),
                const MyTitleTextWidget(
                  text: 'Password?',
                  color: Colors.black,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                const Text('Don\'t worry! It happens. Please enter the'),
                const Text('email address associated with your account.'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                MyTextFormFieldWidget(
                    controller: forgotPasswordController.emailController,
                    lebelText: 'Enter Email ID',
                    keybordType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    icon: Icons.email_outlined,
                    functoin: (value) {
                      return forgotPasswordController.emailValidator();
                    }),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Obx(() => InkWell(
                      onTap: () {
                        forgotPasswordController.onSubmit();
                      },
                      child: MyButtonWidget(
                          isButtonClicked: forgotPasswordController
                              .isForgotSubmitClicked.value,
                          text: 'Submit',
                          buttonColor: Colors.blue,
                          textColor: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
