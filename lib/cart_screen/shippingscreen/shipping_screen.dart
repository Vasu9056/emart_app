import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycart/cart_screen/payment_method/payment_method.dart';
import 'package:mycart/consts/colors.dart';
import 'package:mycart/consts/styles.dart';
import 'package:mycart/controller/cart_controller.dart';
import 'package:mycart/widget_common/custom_textfield.dart';
import 'package:mycart/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: OurButton(
          onPress: () {
            if (controller.addressController.text.length > 1 &&
                controller.cityController.text.length > 2 &&
                controller.stateController.text.length > 2 &&
                controller.pinCodeController.text.length >= 6 &&
                controller.phoneController.text.length ==10) {
              Get.to(() => PaymentMethod());
            } else {
              VxToast.show(context, msg: "Please fill the form properly");
            }
          },
          c: redColor,
          textColor: whiteColor,
          text: "Continue"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
              "Address", "Address", controller.addressController
            ),
            customTextField(
              "City", "City", controller.cityController
            ),
            customTextField(
             "State", "State", controller.stateController
            ),
            customTextField(
              "Pin Code", "Pin Code", controller.pinCodeController
            ),
            customTextField(
              "Phone", "Phone", controller.phoneController
            ),
          ],
        ),
      ),
    );
  }
}
