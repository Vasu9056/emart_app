import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycart/chat_screen/component/sender_bubble.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/consts/firebase_const.dart';
import 'package:mycart/controller/chat_controller.dart';
import 'package:mycart/services/firestore_services.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());
    return Scaffold(
        appBar: AppBar(
          title: "Title".text.fontFamily(semibold).color(darkFontGrey).make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        ),
                      )
                    :  Expanded(
                        child: StreamBuilder(
                          stream: FirestoreServices.getChatMessages(
                              controller.chatDocId.toString()),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(redColor),
                                ),
                              );
                            } else if (snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: "Send a message ..."
                                    .text
                                    .color(darkFontGrey)
                                    .make(),
                              );
                            } else {
                              return ListView(
                                children: snapshot.data!.docs.map((doc) {
                                  var isUser = doc['uid'] == controller.currentId;
                                  return Align(
                                    alignment: isUser
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: senderBubble(doc, isUser),
                                  );
                                }).toList(),
                              );
                            }
                          },
                        ),
                      ),
              ),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: controller.msgController,
                    decoration: const InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey),
                      ),
                    ),
                  )),
                  IconButton(
                      onPressed: () {
                        controller.sendMsg(controller.msgController.text);
                        controller.msgController.clear();
                      },
                      icon: const Icon(Icons.send)),
                ],
              )
                  .box
                  .height(80)
                  .padding(const EdgeInsets.all(12))
                  .margin(const EdgeInsets.only(bottom: 8.0))
                  .make()
            ],
          ),
        ));
  }
}
