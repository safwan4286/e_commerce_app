import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_login/screens/change_password/controller/change_password_controller.dart';
import 'package:user_login/widgets/my_button_widget.dart';
import 'package:user_login/widgets/my_textformfield.dart';
import 'package:user_login/widgets/my_title_text_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  static const routeName = '/change_password';
  ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Form(
            key: changePasswordController.formKey,
            child: SingleChildScrollView(
              reverse: true,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding:
                     EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        alignment: Alignment.centerLeft,
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back)),
                    Image.asset('assets/images/cpassword_image.png'),
                    const MyTitleTextWidget(
                      text: 'Reset',
                      color: Colors.black,
                    ),
                    const MyTitleTextWidget(
                        text: 'Password', color: Colors.black),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Obx(() => MyTextFormFieldWidget(
                        obscureText:
                            changePasswordController.isOldPasswordVisible.value,
                        sufixIcon: IconButton(
                            onPressed: () {
                              changePasswordController
                                      .isOldPasswordVisible.value =
                                  !changePasswordController
                                      .isOldPasswordVisible.value;
                            },
                            icon: Icon(changePasswordController
                                    .isOldPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        controller:
                            changePasswordController.oldPasswordController,
                        lebelText: 'Old Password',
                        keybordType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        onSubmit: (value) {
                          FocusScope.of(context).nextFocus();
                        },
                        icon: Icons.key,
                        functoin: (value) {
                          return changePasswordController
                              .oldPasswordValidator();
                        })),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Obx(() => MyTextFormFieldWidget(
                        obscureText:
                            changePasswordController.isNewPasswordVisible.value,
                        sufixIcon: IconButton(
                            onPressed: () {
                              changePasswordController
                                      .isNewPasswordVisible.value =
                                  !changePasswordController
                                      .isNewPasswordVisible.value;
                            },
                            icon: Icon(changePasswordController
                                    .isNewPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        controller:
                            changePasswordController.newPasswordController,
                        lebelText: 'New Password',
                        focusnode:
                            changePasswordController.focusNodeNewPassword,
                        keybordType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        onSubmit: (value) {
                          FocusScope.of(context).nextFocus();
                        },
                        icon: Icons.lock,
                        functoin: (value) {
                          return changePasswordController
                              .newPasswordValidator();
                        })),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Obx(() => MyTextFormFieldWidget(
                        obscureText: changePasswordController
                            .isConfirmPasswordVisible.value,
                        sufixIcon: IconButton(
                            onPressed: () {
                              changePasswordController
                                      .isConfirmPasswordVisible.value =
                                  !changePasswordController
                                      .isConfirmPasswordVisible.value;
                            },
                            icon: Icon(changePasswordController
                                    .isConfirmPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        controller: changePasswordController
                            .confirmNewPasswordController,
                        lebelText: 'Confirm Password',
                        focusnode:
                            changePasswordController.focusNodeConNewPassword,
                        keybordType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        icon: Icons.lock,
                        functoin: (value) {
                          return changePasswordController
                              .confirmPasswordValidator();
                        })),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Obx(() => InkWell(
                          onTap: () {
                            changePasswordController.onSubmit();
                          },
                          child: MyButtonWidget(
                              isButtonClicked: changePasswordController
                                  .isSubmitClicked.value,
                              text: 'Submit',
                              buttonColor: Colors.blue,
                              textColor: Colors.white),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
