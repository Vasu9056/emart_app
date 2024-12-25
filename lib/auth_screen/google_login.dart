import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/home_screen/home.dart';

class GoogleLogin {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> handleGoogleSignIn(BuildContext context) async {
    try {
      var result = await _googleSignIn.signIn();
      if (result != null) {
        // Handle successful login
        VxToast.show(context, msg: "Login Successful");
        Get.offAll(() => Home());
      } else {
        // No accounts available or user canceled the login
        VxToast.show(context, msg: "No Google accounts available or login canceled");
      }
    } catch (error) {
      VxToast.show(context, msg: "Login Failed: ${error.toString()}");
    }
  }
}

