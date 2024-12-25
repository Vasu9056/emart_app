import 'package:flutter/material.dart';
import 'package:mycart/consts/consts.dart';

Widget applogo() {
  return Image.asset("assets/icons/app_logo.png")
      .box.white
      .size(77, 77)
      .padding(EdgeInsets.all(8))
      .rounded
      .make();
}
