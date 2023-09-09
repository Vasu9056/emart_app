import 'package:emart_app/consts/consts.dart';
import 'package:flutter/cupertino.dart';

Widget FeatureButton({required String? title, required icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(200)
      .margin(EdgeInsets.symmetric(horizontal: 4))
      .white
      .roundedSM
      .padding(EdgeInsets.all(4))
      .outerShadowSm
      .make();
}
