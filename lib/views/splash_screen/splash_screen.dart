import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycart/auth_screen/login_screen.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/consts/firebase_const.dart';
import 'package:mycart/home_screen/home.dart';
import 'package:mycart/widget_common/applogo_widget.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      // Get.to(()=>LoginScreen());
      auth.authStateChanges().listen((User? user) {
        if (user == null) {
          Get.to(() => const LoginScreen());
        } else {
          Get.to(() => Home());
        }
      });
     
    });
  }
  @override
  void initState() {
    super.initState();
    changeScreen();
  }
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.0,
      child: Scaffold(
        backgroundColor: redColor,
        body: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      icSplashBg,
                      width: 300,
                    )),
                const SizedBox(
                  height: 20,
                ),
                applogo(),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'eMart',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  'Version 1.0.0',
                  style: TextStyle(color: Colors.white, fontSize: 14.5),
                ),
                const SizedBox(
                  height: 315,
                ),
              ],
            ),
      ),
    );
  }
}
