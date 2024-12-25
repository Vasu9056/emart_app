import 'package:flutter/material.dart';
import 'package:mycart/consts/consts.dart';

Widget detaliCard({required double width, required String? titl, required String? count}) { // Add the missing type for 'width' parameter
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      SizedBox(height: 5),
      titl!.text.fontFamily(bold).color(darkFontGrey).make(),
    ],
  ).box.white.rounded.width(width).height(67.5).padding(EdgeInsets.all(4)).make();
}
 