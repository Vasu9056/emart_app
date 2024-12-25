import 'package:flutter/material.dart';
Widget OurButton(
    { required String  text,
     Color? c,
     Color? textColor,
     FontWeight? fontWeight,
     VoidCallback ?onPress,
     double? width, String? titl}) {
  return GestureDetector(
    onTap: onPress,
    child: Container(
      padding: const EdgeInsets.all(8),
      width: width,
      height: 35,
      decoration: BoxDecoration(
        color: c,
        // borderRadius: BorderRadius.circular(8),
      ),
      child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          )),
    ),
  );
}
