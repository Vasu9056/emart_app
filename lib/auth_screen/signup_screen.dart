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

class SignUp_Page extends StatefulWidget {
  const SignUp_Page({super.key});
  @override
  State<SignUp_Page> createState() => _SignUp_PageState();
}

class _SignUp_PageState extends State<SignUp_Page> {
  bool? ischeck = false;

  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordretype = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogo(),
            10.heightBox,
            "Join the $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Column(
              children: [
                CustomTextfield(name, nameHint, nameController, false),
                CustomTextfield(email, emailhint, emailController, false),
                CustomTextfield(
                    password, passwordhint, passwordController, true),
                CustomTextfield(retypepass, passwordhint, passwordretype, true),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: forgotpass.text.make())),
                7.5.heightBox,
                Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.red,
                      checkColor: Colors.white,
                      value: ischeck,
                      onChanged: (newValue) {
                        setState(() {
                          ischeck = newValue;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: RichText(
                          text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'I agreed to the ',
                            style: TextStyle(
                              fontFamily: bold,
                              color: Color.fromRGBO(107, 115, 119, 1),
                            ),
                          ),
                          TextSpan(
                            text: termsandcond,
                            style: TextStyle(
                              fontFamily: bold,
                              color: Colors.red,
                            ),
                          ),
                          TextSpan(
                            text: '&',
                            style: TextStyle(
                              fontFamily: bold,
                              color: Color.fromRGBO(107, 115, 119, 1),
                            ),
                          ),
                          TextSpan(
                              text: privacypolicy,
                              style: TextStyle(
                                fontFamily: bold,
                                color: Colors.red,
                              ))
                        ],
                      )),
                    )
                  ],
                ),
                controller.isLoading.value
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : OurButton(
                        text: "SignUp",
                        c: lightGolden,
                        textColor: redColor,
                        fontWeight: FontWeight.bold,
                        onPress: () async {
                          if (ischeck != false) {
                            try {
                              controller.isLoading(true);
                              await controller.SignUpMethod(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context)
                                  .then((value) {
                                return controller.storeuserdata(
                                    name: nameController.text,
                                    password: passwordController.text,
                                    email: emailController.text);
                              }).then((value) {
                                VxToast.show(context, msg: loginsuccesfully);
                                Get.to(() => Home());
                              });
                            } catch (e) {
                              auth.signOut();
                              VxToast.show(context, msg: e.toString());
                              controller.isLoading(false);
                            }
                          }
                        },
                        width: 500),
                10.heightBox,
                createNewAccount.text.color(fontGrey).make(),
              ],
            )
                .box
                .white
                .rounded
                .shadowSm
                .width(context.screenWidth - 70)
                .padding(const EdgeInsets.all(16))
                .make(),
          ],
        ),
      ),
    ));
  }
}
