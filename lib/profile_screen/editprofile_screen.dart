import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/controller/profile_controller.dart';
import 'package:mycart/widget_common/bg_widget.dart';
import 'package:mycart/widget_common/custom_textfield.dart';
import 'package:mycart/widget_common/our_button.dart';

import '../consts/images.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  EditProfileScreen({super.key, this.data});
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    // controller.nameController.text = data['name'];
    // controller.passController.text = data['password'];
    return bgWidget(
      Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(),
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //if data img url and controller path isempty
              data['imgurl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  :

                  //if data img url is not empty and controller path is empty
                  data['imgurl'] != '' && controller.profileImgPath.isEmpty
                      ? Image.network(
                          data['imgurl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      :

                      //if both are emplty
                      Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              OurButton(
                text: "Change",
                c: redColor,
                textColor: whiteColor,
                fontWeight: FontWeight.bold,
                onPress: () {
                  controller.changeImage(context);
                },
                width: 90,
              ),
              const Divider(),
              20.heightBox,
              customTextField(name, nameHint, controller.nameController),
              10.heightBox,
              customTextField(
                  oldpassword, passwordhint, controller.oldpassController),
              10.heightBox,
              customTextField(
                  newpassword, passwordhint, controller.newpassController),
              20.heightBox,
              Obx(
                () => controller.isloading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : OurButton(
                        text: "Save",
                        c: redColor,
                        textColor: whiteColor,
                        fontWeight: FontWeight.bold,
                        onPress: () async {
                          controller.isloading(true);

                          //if profile image is not empty
                          if (controller.profileImgPath.isNotEmpty) {
                            await controller.uploadProfileImage();
                          }
                          //password math with oldpasscontroller
                          if (data['password'] ==
                              controller.oldpassController.text) {

                            await controller.changeAuthPassword(
                              email: data['email'],
                              password: controller.oldpassController.text,
                              newpassword: controller.newpassController.text,
                            );
                            
                            await controller.updateProfile(
                              name: controller.nameController.text,
                              password: controller.newpassController.text,
                              imgurl: controller.profileImagelink,
                            );
                            VxToast.show(context, msg: "Updated");
                          }
                          //password is not match
                          else {
                            VxToast.show(context, msg: "Wrong old password");
                            controller.isloading(false);
                          }
                        },
                        width: 450.0,
                      ),
              ),
            ],
          )
              .box
              .white
              .shadowSm
              .rounded
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .make(),
        ),
      ),
    );
  }
}
