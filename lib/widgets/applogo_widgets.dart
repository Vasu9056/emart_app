import 'package:emart_app/consts/images.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
Widget applogo() {
  return Image.asset(icAppLogo).box
      .white
      .size(77, 77)
      .padding(EdgeInsets.all(8))
      .rounded
      .make();
}


