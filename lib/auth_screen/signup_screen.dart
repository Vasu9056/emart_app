import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/controller/auth_controller.dart';
import 'package:mycart/home_screen/home.dart';
import 'package:mycart/widget_common/applogo_widget.dart';
import 'package:mycart/widget_common/bg_widget.dart';
import 'package:mycart/widget_common/custom_textfield.dart';
import 'package:mycart/widget_common/our_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
            Obx(()=>
               Column(
                children: [
                  customTextField(name, nameHint, nameController),
                  customTextField(email, emailhint, emailController),
                  customTextField(password, passwordhint, passwordController),
                  customTextField(retypepass, passwordhint, passwordretype),
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
                  controller.isloading.value?CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),):
                  OurButton(
                      text: "SignUp",
                      c: ischeck == true ? redColor : lightGrey,
                      textColor: whiteColor,
                      fontWeight: FontWeight.bold,
                      onPress: () async {
                        if (ischeck == true) {
                          controller.isloading(true);
                          try {
                            await controller.signup(
                              context: context,
                              email: emailController.text,
                              password: passwordController.text,
                            ).then((value)=>{
                              controller.storeUserdata(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            }).then((value){
              
                              VxToast.show(context, msg: Login);
                              Get.to(() => Home());
                            });
                          } catch (e) {
                             controller.signout(context: context);
                             // ignore: use_build_context_synchronously
                             VxToast.show(context, msg: e.toString());
                             controller.isloading(false);
                          }
                        }
                      },
                      width: 500),
                  10.heightBox,
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: alreadyAccount,
                          style: TextStyle(fontFamily: bold, color: fontGrey),
                        ),
                        TextSpan(
                          text: login,
                          style: TextStyle(fontFamily: bold, color: redColor),
                        ),
                      ],
                    ),
                  ).onTap(() {
                    Get.back();
                  })
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
