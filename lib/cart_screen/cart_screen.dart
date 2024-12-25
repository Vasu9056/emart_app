import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycart/cart_screen/shippingscreen/shipping_screen.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/consts/firebase_const.dart';
import 'package:mycart/controller/cart_controller.dart';
import 'package:mycart/services/firestore_services.dart';
import 'package:mycart/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
            width: context.screenWidth - 60,
            child: OurButton(
                c: redColor,
                onPress: () {
                  Get.to(()=>
                      const ShippingScreen());
                },
                text: "Proceed To Shipping",
                textColor: whiteColor)),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Shopping cart"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getCart(user!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is Empty".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);

                controller.productSnapshot=data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                var item = data[index];
                                return ListTile(
                                  leading: Image.network(
                                    "${item['img']}",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  title:
                                      "${item['title']}  (x${data[index]['qty']})"
                                          .text
                                          .fontFamily(semibold)
                                          .size(16)
                                          .make(),
                                  subtitle: "${item['tprice']}"
                                      .numCurrency
                                      .text
                                      .color(redColor)
                                      .fontFamily(semibold)
                                      .make(),
                                  trailing: Icon(
                                    Icons.delete,
                                    color: redColor,
                                  ).onTap(() {
                                    FirestoreServices.deleteDocument(
                                        data[index].id);
                                  }),
                                ); // ListTile
                              })),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total price"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          Obx(
                            () => "${controller.totalP}"
                                .numCurrency
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .make(),
                          ),
                        ],
                      )
                          .box
                          .padding(EdgeInsets.all(12))
                          .color(lightGolden)
                          .width(context.screenWidth - 60)
                          .roundedSM
                          .make(),
                      10.heightBox,
                    ],
                  ),
                );
              }
            }));
  }
}
