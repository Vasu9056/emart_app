import 'dart:io';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/profile_controller.dart';
import 'package:emart_app/widgets/bg_widget.dart';
import 'package:emart_app/widgets/ourbutton.dart';
import 'package:get/get.dart';
import '../widgets/Textfield.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return bgWidget(Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => controller.profileImgpath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : Image.file(
                      File(
                        controller.profileImgpath.value,
                      ),
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make(),
            ),
            10.heightBox,
            OurButton(
                text: "Change",
                c: redColor,
                textColor: whiteColor,
                fontWeight: FontWeight.bold,
                onPress: () {
                  controller.changeImage(context);
                },
                width: 90),
            const Divider(),
            20.heightBox,
            CustomTextfield(name, nameHint, controller.nameController, false),
            10.heightBox,
            CustomTextfield(
              oldpassword,
              passwordhint,
              controller.oldpassController,
              true,
            ),
            10.heightBox,
            CustomTextfield(
              newpassword,
              passwordhint,
              controller.newpassController,
              true,
            ),
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
                        if (controller.profileImgpath.value.isNotEmpty) {
                          controller.uploadProfileImage();
                        } else {
                          controller.profileImagelink = data['imgurl'];
                        }

                        //if old password matches database

                        if (data['password'] ==
                            controller.oldpassController.text) {
                          await controller.changeAuthpassword(
                            email: data['email'],
                            password: controller.oldpassController.text,
                            newpassword: controller.newpassController.text,
                          );

                          await controller.updateProfile(
                            imgurl: controller.profileImagelink,
                            name: controller.nameController.text,
                            password: controller.newpassController.text,
                          );
                          VxToast.show(context, msg: "Updated");
                        } else {
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
            .make()));
  }
}
