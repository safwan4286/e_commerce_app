import 'package:flutter/material.dart';
import 'package:user_login/screens/forgot_password/forgot_password_screen.dart';
import 'package:user_login/screens/signup/sign_up_screen.dart';
import 'package:user_login/widgets/my_button_widget.dart';
import 'package:user_login/widgets/my_textformfield.dart';
import 'package:user_login/widgets/my_title_text_widget.dart';
import 'package:get/get.dart';

import 'controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static const routeName = '/login_screen';
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: loginController.loginFormKey,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              children: [
                Image.asset('assets/images/login_image.png'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                const MyTitleTextWidget(
                  text: 'Login',
                  color: Colors.black,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                MyTextFormFieldWidget(
                    controller: loginController.emailController,
                    lebelText: 'Email',
                    keybordType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    icon: Icons.email,
                    functoin: (value) {
                      return loginController.loginEmailValidator();
                    }),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Obx(() => MyTextFormFieldWidget(
                    sufixIcon: IconButton(
                      icon: Icon(loginController.isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        loginController.isPasswordVisible.value =
                            !loginController.isPasswordVisible.value;
                      },
                    ),
                    obscureText: loginController.isPasswordVisible.value,
                    controller: loginController.passwordController,
                    lebelText: 'Password',
                    keybordType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    icon: Icons.lock,
                    functoin: (value) {
                      return loginController.loginPasswordValidator();
                    })),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                // Container(
                //   alignment: Alignment.centerRight,
                //   child: TextButton(
                //     onPressed: () {
                //       Get.toNamed(ForgotPasswordScreen.routeName)?.then(
                //         (value) {
                //           loginController.emailController.clear();
                //           loginController.passwordController.clear();
                //         },
                //       );
                //     },
                //     child: const Text(
                //       'Forgot Password?',
                //     ),
                //   ),
                // ),
                Obx(() => InkWell(
                      onTap: () {
                        loginController.onLogin();
                      },
                      child: MyButtonWidget(
                        isButtonClicked: loginController.isLoginClicked.value,
                        text: 'Login',
                        buttonColor: Colors.blue,
                        textColor: Colors.white,
                      ),
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 15),
                        child: const Divider(
                          thickness: 2,
                        ),
                      ),
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(fontSize: 16),
                    ),
                    Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(left: 15, right: 10),
                            child: const Divider(thickness: 2))),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.065,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.07,
                          child: Image.asset(
                            'assets/images/google_image.png',
                          ),
                        ),
                        const Text(
                          'Login With Google',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('New to App?'),
                    TextButton(
                        onPressed: () {
                          Get.toNamed(SignupScreen.routeName)?.then(
                            (value) {
                              loginController.emailController.clear();
                              loginController.passwordController.clear();
                            },
                          );
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
