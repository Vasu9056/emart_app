import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/styles.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget CustomTextfield(String? title, String? hint, controller, bool ispass) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        obscureText: ispass,
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontFamily: semibold,
              color: textfieldGrey,
            ),
            isDense: true, // small show
            filled: true,
            border: InputBorder.none, // when we click on box show the border
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: redColor), // when we click on box show the border
            )),
      ),
      5.heightBox,
    ],
  );
}
