import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycart/controller/cart_controller.dart';
import 'package:mycart/home_screen/home.dart';
import 'package:mycart/widget_common/list.dart';
import 'package:mycart/widget_common/our_button.dart';
import '../../../consts/consts.dart';

class PaymentMethod extends StatelessWidget {
PaymentMethod({super.key});
 var contorller = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
   
    return  Obx(()=>
       Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            title: "Choose Payment Method"
                .text
                .fontFamily(semibold)
                .color(darkFontGrey)
                .make(),
          ),
          bottomNavigationBar: SizedBox(
            height: 60,
            child:
                contorller.placingOrder.value
                    ? const Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor)),
                      )
                    :
                OurButton(
              onPress: () async {
                contorller.placeMyOrder(
                  orderPaymentMethod: pamentMethodString[contorller.paymentIndex.value],
                  totalAmount: contorller.totalP.value,
                );
                // ignore: use_build_context_synchronously
                VxToast.show(context, msg: "Order placed successfully");
                Get.offAll(Home());
              },
              c: redColor,
              textColor: whiteColor,
              text: "Place my order",
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Obx(()=>
               Column(
                  children: List.generate(
                    pamentMethodImg.length,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          contorller.changePaymentIndex(index);
                        },
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: contorller.paymentIndex.value == index
                              ? redColor
                              : Colors.transparent,
                              width: 4,
                            ),
                          ),
                          margin:  EdgeInsets.only(
                            bottom: 8,
                          ),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Image.asset(
                                pamentMethodImg[index],
                                // colorBlendMode: controller.PaymentIndex.value == index? Colors.black.withOpacity(0.4): Colors.transparent,
                                width: double.infinity,
                                height: 120,
                                fit: BoxFit.cover,
                               
                              ),
                              contorller.paymentIndex.value == index?
              
                            Transform.scale(
                                scale: 1.3,
                              child: Checkbox(
                                activeColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                value: true, onChanged: (value) {
                                                     
                              }),
                            ):Container(),
              
                              Positioned(
                                bottom: 5, //commet
                                right: 10,
                                child: pamentMethodString[index]
                                    .text
                                    .color(whiteColor)
                                    .fontFamily(semibold)
                                    .size(16)
                                    .make(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ),
            ),
          ),
    );
  }
}
