import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_login/screens/change_password/change_password_screen.dart';
import 'package:user_login/screens/forgot_password/forgot_password_screen.dart';
import 'package:user_login/screens/home/home_screen.dart';
import 'package:user_login/screens/otp_verification/otp_verification_screen.dart';
import 'package:user_login/screens/signup/sign_up_screen.dart';
import 'package:user_login/screens/splash/splash_screen.dart';
import './screens/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      getPages: [
        GetPage(name: SignupScreen.routeName, page: () => SignupScreen()),
        GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
        GetPage(
            name: OtpVerificationScreen.routeName,
            page: () => OtpVerificationScreen()),
        GetPage(name: HomeScreen.routeName, page: () => HomeScreen()),
        GetPage(
            name: ForgotPasswordScreen.routeName,
            page: () => ForgotPasswordScreen()),
        GetPage(
          name: ChangePasswordScreen.routeName,
          page: () => ChangePasswordScreen(),
        )
      ],
    );
  }
}
