import 'package:emart_app/auth_screen/login_screen.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets/applogo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home_screen/home.dart';
import 'package:emart_app/consts/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Scratch_Scren extends StatefulWidget {
  const Scratch_Scren({super.key});

  @override
  State<Scratch_Scren> createState() => _Scratch_ScrenState();
}

class _Scratch_ScrenState extends State<Scratch_Scren> {
  changeScreen() {
    Future.delayed(Duration(seconds: 3), () {
      // Get.to(()=>Login_Page());
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Login_Page()));
        } else {
          Get.to(() => Home());
        }
      });
    });
  }

  void initState() {
    changeScreen();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      child: Scaffold(
        backgroundColor: redColor,
        body: SingleChildScrollView(
          child: Column(
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
              credits.text.white.fontFamily(semibold).make(),
            ],
          ),
        ),
      ),
    );
  }
}
