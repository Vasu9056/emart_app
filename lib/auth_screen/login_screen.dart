import 'package:emart_app/auth_screen/signup_screen.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/home_screen/home.dart';
import 'package:emart_app/widgets/Textfield.dart';
import 'package:emart_app/widgets/applogo_widgets.dart';
import 'package:emart_app/widgets/bg_widget.dart';
import 'package:emart_app/widgets/list.dart';
import 'package:emart_app/widgets/ourbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login_Page extends StatelessWidget {
  const Login_Page({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogo(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  CustomTextfield(
                      email, emailhint, controller.emailController, false),
                  CustomTextfield(password, passwordhint,
                      controller.passwordController, true),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgotpass.text.make())),
                  10.heightBox,
                  controller.isLoading.value
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : OurButton(
                          text: "Login",
                          c: redColor,
                          textColor: Colors.white,
                          fontWeight: FontWeight.bold,
                          onPress: () async {
                            controller.isLoading(true);

                            await controller.LoginMethod(context: context)
                                .then((value) {
                              if (value != null) {
                                VxToast.show(context, msg: loginsuccesfully);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              } else {
                                controller.isLoading(false);
                              }
                            });
                          },
                          width: 500),
                  10.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  10.heightBox,
                  OurButton(
                      text: "SignUp",
                      c: lightGolden,
                      textColor: redColor,
                      fontWeight: FontWeight.bold,
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp_Page()));
                      },
                      width: 500),
                  10.heightBox,
                  login.text.color(fontGrey).make(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: lightGrey,
                          child: Image.asset(
                            socialIconslist[index],
                            width: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  .box
                  .white
                  .rounded
                  .shadowSm
                  .width(context.screenWidth - 70)
                  .padding(const EdgeInsets.all(16))
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}
