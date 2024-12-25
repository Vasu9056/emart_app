import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycart/consts/firebase_const.dart';
import 'package:mycart/controller/home_controller.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chats = firestore.collection(chatCollection);
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];
  var isLoading = false.obs;

  var senderName = Get.find<HomeController>().username.value; // Convert RxString to regular string
  var currentId = user!.uid;

  var msgController = TextEditingController();

  dynamic chatDocId;

  getChatId() async {
    isLoading(true);
    await chats
        .where('users', isEqualTo: {friendId: null, currentId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            chats.add({
              'created_on': null,
              'last_msg': '',
              'users': {friendId: null, currentId: null},
              'to_id': '',
              'from_id': '',
              'friend_name': friendName,
              'sender_name': senderName,
            }).then((value) => chatDocId = value.id); // Ensure chatDocId is set to the document ID
          }
        });

    isLoading(false);
  }

  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      await chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'to_id': friendId,
        'from_id': currentId,
      });

      chats.doc(chatDocId).collection(messageCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });
    }
  }
}
