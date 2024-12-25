import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycart/chat_screen/chat_screen.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/controller/product_controller.dart';
import 'package:mycart/widget_common/list.dart';
import 'package:mycart/widget_common/our_button.dart';

// ignore: must_be_immutable
class ItemDetails extends StatelessWidget {
  var controller = Get.find<ProductController>();
  ItemDetails({super.key, this.title, this.data});
  final String? title;
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    print(Colors.yellow.value);

    print(Colors.accents);
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.resetValues();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: title != null
              ? title!.text.color(Colors.black).fontFamily(bold).make()
              : const Text('Dummy Title'),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share),
            ),
            Obx(
              () => IconButton(
                onPressed: () {
                  if (controller.isFav.value) {
                    controller.removeFromWishlist(data.id, context);
                    // controller.isFav(false);
                  } else {
                    controller.addToWishlist(data.id, context);
                    // controller.isFav(true);
                  }
                },
                icon: Icon(
                  Icons.favorite,
                  color: controller.isFav.value ? redColor : darkFontGrey,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                      height: 300,
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      viewportFraction: 1.0,
                      itemCount: data['p_imgs'].length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          data['p_imgs'][index],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    20.heightBox,
                    12.heightBox,
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data['p_rating'].toString()),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      stepInt: true,
                    ),
                    15.heightBox,
                    "${data['p_price']}"
                        .numCurrency
                        .text
                        .color(redColor)
                        .fontWeight(FontWeight.bold)
                        .fontFamily(bold)
                        .size(18)
                        .make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller"
                                  .text
                                  .color(Colors.white)
                                  .fontFamily(semibold)
                                  .make(),
                              6.heightBox,
                              "${data['p_seller']}"
                                  .text
                                  .color(Colors.black)
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make(),
                            ],
                          ),
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child:
                              Icon(Icons.message_rounded, color: darkFontGrey),
                        ).onTap(() {
                          Get.to(() => ChatScreen(),
                              arguments: [data['p_seller'], data['vendor_id']]);
                        })
                      ],
                    )
                        .box
                        .height(60)
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .color(textfieldGrey)
                        .make(),
                    20.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color"
                                    .text
                                    .color(textfieldGrey)
                                    .fontFamily(bold)
                                    .make(),
                              ),
                              Row(
                                children: List.generate(
                                  data['p_colors'].length,
                                  (index) => Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      VxBox()
                                          .roundedFull
                                          .color(Color(int.parse(
                                              data['p_colors'][index]
                                                  .toString())))
                                          .margin(const EdgeInsets.symmetric(
                                              horizontal: 6))
                                          .size(40, 40)
                                          .make()
                                          .onTap(() {
                                        controller.changeColorIndex(index);
                                      }),
                                      Visibility(
                                          visible:
                                              controller.colorIndex.value ==
                                                  index,
                                          child: Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ).box.white.padding(const EdgeInsets.all(8)).make(),
                          //quantity row

                          Padding(
                            padding: const EdgeInsets.only(left: 8.25),
                            child: Obx(
                              () => Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Quantity"
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.decreaseQuantity();
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.remove)),
                                      // 6.widthBox,
                                      controller.quantity.value.text
                                          .size(16)
                                          .color(darkFontGrey)
                                          .fontFamily(bold)
                                          .make(),
                                      IconButton(
                                          onPressed: () {
                                            controller.increaseQuantity(
                                                int.parse(data['p_quantity']));
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.add)),
                                      6.widthBox,
                                      "${data['p_quantity']} available"
                                          .text
                                          .size(16)
                                          .color(textfieldGrey)
                                          .fontFamily(bold)
                                          .make(),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 8.25),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child:
                                      "Total".text.color(textfieldGrey).make(),
                                ),
                                Row(
                                  children: [
                                    controller.totalPrice.value.numCurrency.text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .size(18)
                                        .make(),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ).box.white.shadowSm.make(),
                    ),
                    10.heightBox,
                    "Description"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    "${data['p_description']}".text.color(textfieldGrey).make(),
                    10.heightBox,
                    ListView(
                        shrinkWrap: true,
                        children: List.generate(
                            itemdetailbl.length,
                            (index) => ListTile(
                                  title: itemdetailbl[index]
                                      .text
                                      .color(darkFontGrey)
                                      .make(),
                                  trailing: const Icon(Icons.arrow_forward),
                                ))),
                    20.heightBox,
                    productsyoumaylike.text
                        .color(darkFontGrey)
                        .fontFamily(bold)
                        .size(16)
                        .make(),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            6,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      imgP1,
                                      fit: BoxFit.cover,
                                      width: 150,
                                    ),
                                    "Laptop 4GB/64GB"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "\$600"
                                        .text
                                        .fontFamily(bold)
                                        .color(Colors.red)
                                        .size(16)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .color(Colors.white)
                                    .roundedSM
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .padding(const EdgeInsets.all(8))
                                    .make()),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: OurButton(
                  text: 'Add to Cart',
                  c: redColor,
                  textColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  onPress: () {
                    if (controller.quantity.value == 0) {
                      VxToast.show(context, msg: 'Please select quantity');
                      return;
                    } else {
                      controller.addToCart(
                          title: data['p_name'],
                          img: data['p_imgs'][0],
                          sellername: data['p_seller'],
                          color: data['p_colors'][controller.colorIndex.value],
                          qty: controller.quantity.value,
                          tprice: controller.totalPrice.value,
                          context: context,
                          vendorId: data['vendor_id']);
                      VxToast.show(context, msg: 'Added to Cart');
                    }
                  },
                  width: 500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
