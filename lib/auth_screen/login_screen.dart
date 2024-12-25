import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycart/auth_screen/signup_screen.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/controller/auth_controller.dart';
import 'package:mycart/home_screen/home.dart';
import 'package:mycart/widget_common/applogo_widget.dart';
import 'package:mycart/widget_common/bg_widget.dart';
import 'package:mycart/widget_common/custom_textfield.dart';
import 'package:mycart/widget_common/list.dart';
import 'package:mycart/widget_common/our_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    var passwordController = TextEditingController();
    var emailController = TextEditingController();
    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Center(
        child: 
          Column(children: [
            (context.screenHeight * 0.1).heightBox,
            applogo(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
              Obx(()=>
                 Column(
                  children: [
                    customTextField(email, emailhint, emailController),
                    customTextField(password, passwordhint, passwordController),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {}, child: forgotpass.text.make())),
                    10.heightBox,

                    controller.isloading.value?CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),):
                    OurButton(
                        text: "Login",
                        c: redColor,
                        textColor: Colors.white,
                        fontWeight: FontWeight.bold,
                        onPress: () async{
                
                          controller.isloading(true);
                         await controller.login(email: emailController.text, password: passwordController.text, context: context).then((value){
                          if(value!=null)
                          {
                            VxToast.show(context, msg: Login);
                            Get.offAll(()=>Home());
                          }
                          else
                          {
                            controller.isloading(false);
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
                          Get.to(() => SignUpScreen());
                        },
                        width: 500),
                    10.heightBox,
                    login.text.color(fontGrey).make(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        1,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: lightGrey,
                            child: Image.asset(
                              socialIconslist[1],
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
          ]),
        ),
      ),
    );
  }
}
