import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_login/screens/signup/widgets/gender_widget.dart';
import 'package:user_login/widgets/my_button_widget.dart';
import 'package:get/get.dart';
import 'controller/signup_controller.dart';
import '../../widgets/my_title_text_widget.dart';
import '../../widgets/my_textformfield.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  static const routeName = '/signup_screen';

  SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
            key: signupController.signupFormKey,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                children: [
                  Image.asset('assets/images/signup_image.png'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  const MyTitleTextWidget(text: 'Signup', color: Colors.black),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  MyTextFormFieldWidget(
                      controller: signupController.emailController,
                      lebelText: 'Email',
                      keybordType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      icon: Icons.email_outlined,
                      functoin: (value) {
                        return signupController.emailValidator();
                      }),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  MyTextFormFieldWidget(
                    functoin: (value) {
                      return signupController.nameValidator();
                    },
                    keybordType: TextInputType.name,
                    lebelText: 'Full Name',
                    icon: Icons.person_outline,
                    controller: signupController.nameController,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  MyTextFormFieldWidget(
                    functoin: (value) {
                      return signupController.phoneValidator();
                    },
                    textInputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    controller: signupController.phoneController,
                    keybordType: TextInputType.number,
                    lebelText: 'Phone',
                    icon: Icons.phone_outlined,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  // MyTextFormFieldWidget(
                  //     controller: signupController.genderController,
                  //     lebelText: 'Gender',
                  //     keybordType: TextInputType.text,
                  //     textInputAction: TextInputAction.next,
                  //     icon: Icons.person_2,
                  //     functoin: (value) {
                  //       return signupController.gebderValidator();
                  //     }),
                  GenderWidget(
                    signupController: signupController,
                    genderValidator: signupController.genderValidator,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  Obx(() => MyTextFormFieldWidget(
                      obscureText: signupController.isPasswordVisible.value,
                      sufixIcon: IconButton(
                          onPressed: () {
                            signupController.isPasswordVisible.value =
                                !signupController.isPasswordVisible.value;
                          },
                          icon: Icon(signupController.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      controller: signupController.passwordController,
                      lebelText: 'Password',
                      onSubmit: (p0) {
                        FocusScope.of(context).nextFocus();
                      },
                      keybordType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      icon: Icons.lock,
                      functoin: (value) {
                        return signupController.passwordValidator();
                      })),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  MyTextFormFieldWidget(
                      controller: signupController.addressController,
                      lebelText: 'Address',
                      keybordType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.done,
                      textInputFormatter: [
                        LengthLimitingTextInputFormatter(100),
                      ],
                      icon: Icons.location_city,
                      focusnode: signupController.addressFocus,
                      functoin: (value) {
                        return signupController.addressValidator();
                      }),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(
                          text: 'By signing up, you\'re agree to our ',
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: 'Terms & Conditions ',
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                    content: Text('Terms & Conditions....')),
                              );
                            }),
                      const TextSpan(
                          text: 'and ', style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                    content: Text('Privacy Policy....')),
                              );
                            }),
                    ]),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Obx(() => InkWell(
                        onTap: () {
                          if (signupController.genderType.value.isEmpty) {
                            signupController.genderValidator.value =
                                'Please select gender';
                          } else {
                            signupController.genderValidator.value = '';
                          }
                          signupController.onSignup();
                        },
                        child: MyButtonWidget(
                          isButtonClicked:
                              signupController.isSignupClicked.value,
                          buttonColor: Colors.blue,
                          textColor: Colors.white,
                          text: 'Continue',
                        ),
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Joined us before?'),
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ))
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
