import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart'; // Ensure this import is added

Widget exitDialog(BuildContext context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit?"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OurButton(
                c: redColor,
                onPress: () {
                  SystemNavigator.pop();
                },
                textColor: whiteColor,
                text: "Yes"),
            OurButton(
                c: redColor,
                onPress: () {
                  Navigator.pop(context);
                },
                textColor: whiteColor,
                text: "No"),
          ],
        ),
      ],
    ).box.color(lightGrey).padding(EdgeInsets.all(12)).rounded.make(),
  );
}
