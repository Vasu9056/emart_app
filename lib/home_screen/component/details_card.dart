import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart'; // Import 'material' instead of 'cupertino'

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
 