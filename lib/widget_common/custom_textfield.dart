import 'package:flutter/material.dart';
import 'package:mycart/consts/consts.dart';
Widget customTextField(String? title, String? hint, controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        // obscureText: ispass,
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontFamily: semibold,
              color: textfieldGrey,
            ),
            isDense: true,
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
