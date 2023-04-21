import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:user_login/screens/home/home_screen.dart';
import 'package:user_login/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? isLoginCheck;

  @override
  void initState() {
    goToscreen();
    super.initState();
  }

  Future<void> goToscreen() async {
    await Future.delayed(const Duration(seconds: 2));
    SharedPreferences pref = await SharedPreferences.getInstance();
    isLoginCheck = pref.getBool('isLogin');
    if (isLoginCheck == true) {
      Get.offNamed(HomeScreen.routeName);
    } else {
      Get.offNamed(LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
