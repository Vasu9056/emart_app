import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycart/auth_screen/login_screen.dart';
import 'package:mycart/chat_screen/message_screen.dart';
import 'package:mycart/consts/colors.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/consts/firebase_const.dart';
import 'package:mycart/consts/images.dart';
import 'package:mycart/controller/auth_controller.dart';
import 'package:mycart/controller/profile_controller.dart';
import 'package:mycart/order_screen/order_screen.dart';
import 'package:mycart/profile_screen/detail_card.dart';
import 'package:mycart/profile_screen/editprofile_screen.dart';
import 'package:mycart/services/firestore_services.dart';
import 'package:mycart/widget_common/bg_widget.dart';
import 'package:mycart/widget_common/list.dart';
import 'package:mycart/wishlist_screen/wishlist_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  var controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder(
          stream: FirestoreServices.getUser(user!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            controller.nameController.text = data['name'];
                            // controller.passController.text = data['password'];
                            Get.to(() => EditProfileScreen(data: data));
                          },
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Row(
                        children: [
                          data['imgurl'] == ''
                              ? Image.asset(
                                  imgProfile2,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make()
                              : Image.network(
                                  data['imgurl'],
                                  width: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make(),
                          15.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                "${data['name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .make(),
                                "${data['email']}"
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .make(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                await Get.put(() => AuthController().signout(context: context));
                                Get.offAll(() => LoginScreen());
                              },
                              child: "Log out".text.white.size(16).make(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    10.heightBox,
                    FutureBuilder(
                      future: FirestoreServices.getCounts(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(whiteColor),
                          );
                        } else {
                         var countData = snapshot.data;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              detaliCard(
                                  width: context.screenWidth / 3.2,
                                  titl: 'In your cart',
                                  count: countData[0].toString()),
                              detaliCard(
                                  width: context.screenWidth / 3.2,
                                  titl: 'In your wishlist',
                                  count: countData[1].toString()),
                              detaliCard(
                                  width: context.screenWidth / 3.2,
                                  titl: 'Your Orders',
                                  count: countData[2].toString()),
                            ],
                          );
                        }
                      },
                    ),
                    5.heightBox,
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: profileButtonList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => const WishlistScreen());
                                break;
                              case 1:
                                Get.to(() => const OrdersScreen());
                                break;
                              case 2:
                                Get.to(() => const MessagesScreen());
                                break;
                            }
                          },
                          title: profileButtonList[index]
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          leading: Image.asset(
                            profileButtonIcon[index],
                            width: 22,
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          color: lightGrey,
                        );
                      },
                    )
                        .box
                        .white
                        .rounded
                        .shadowSm
                        .margin(const EdgeInsets.all(12))
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .make()
                        .box
                        .color(redColor)
                        .make(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
