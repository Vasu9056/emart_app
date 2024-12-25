import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:mycart/consts/consts.dart';
import 'package:intl/intl.dart'; // Ensure this import is added

Widget senderBubble(DocumentSnapshot data, bool isUser) {
  var t = data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = DateFormat("h:mma").format(t);

  return Container(
    padding: const EdgeInsets.all(8.0),
    margin: const EdgeInsets.only(bottom: 9),
    decoration: BoxDecoration(
      color: isUser ? Colors.red : darkFontGrey,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white, width: 2), // Add border to all sides
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        "${data['msg']}".text.white.size(16).make(),
        10.heightBox,
        "$time".text.color(whiteColor.withOpacity(0.5)).make(),
      ],
    ),
  );
}