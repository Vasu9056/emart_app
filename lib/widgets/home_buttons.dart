import 'package:emart_app/consts/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

import '../consts/consts.dart';
Widget homeButtons({ height, width, icon,  String ?title, }){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
   children: [
     Image.asset(icon, width: 26,),
     8.heightBox,
     title!.text.fontFamily(semibold).color(darkFontGrey).make(),

   ],
).box.rounded.white.size(width,height).shadowSm.make();
}