import 'package:emart_app/auth_screen/login_screen.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/images.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/controller/profile_controller.dart';
import 'package:emart_app/controller/services/firestore_services.dart';
import 'package:emart_app/home_screen/component/details_card.dart';
import 'package:emart_app/home_screen/home.dart';
import 'package:emart_app/profile_screen/edit_profile_screen.dart';
import 'package:emart_app/widgets/bg_widget.dart';
import 'package:emart_app/widgets/list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  var controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder(
          stream: FireStoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            Get.to(() => EditProfileScreen(
                                  data: data,
                                ));
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                await Get.put(AuthController())
                                    .signoutmethod(context: context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login_Page()));
                              },
                              child: "Log out".text.white.size(16).make(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        detaliCard(
                            width: context.screenWidth / 3.2,
                            titl: 'in your cart',
                            count: data['cart_count']),
                        detaliCard(
                            width: context.screenWidth / 3.2,
                            titl: 'in your wishlist',
                            count: data['wishlist_count']),
                        detaliCard(
                            width: context.screenWidth / 3.2,
                            titl: 'Your Orders',
                            count: data['Order_count'])
                      ],
                    ),
                    // 5.heightBox,
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: profileButtonList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: profileButtonList[index]
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            leading: Image.asset(
                              profileButtonIcon[index],
                              width: 22,
                            ));
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
