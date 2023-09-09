import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets/list.dart';
import 'package:emart_app/widgets/ourbutton.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({Key? key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    print(Colors.yellow.value);
    
    print(Colors.accents);
    return Scaffold(
      appBar: AppBar(
        title: title != null
            ? title!.text.color(Colors.black).fontFamily(bold).make()
            : const Text('Dummy Title'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_outline),
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
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        imgFc5,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  20.heightBox,
                  title!.text
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .size(20)
                      .make(),
                  12.heightBox,
                  VxRating(
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    size: 25,
                    stepInt: true,
                  ),
                  15.heightBox,
                  "\$30000"
                      .text
                      .color(redColor)
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
                            "In House Brands"
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
                        child: Icon(Icons.message_rounded, color: darkFontGrey),
                      ),
                    ],
                  )
                      .box
                      .height(60)
                      .padding(const EdgeInsets.symmetric(horizontal: 16))
                      .color(textfieldGrey)
                      .make(),
                  20.heightBox,
                  Column(
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
                              3,
                              (index) => VxBox()
                                  .roundedFull
                                  .color(Vx.randomPrimaryColor)
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 6))
                                  .size(40, 40)
                                  .make(),
                            ),
                          ),
                        ],
                      ).box.white.padding(const EdgeInsets.all(8)).make(),
                      //quantity row

                      Padding(
                        padding: const EdgeInsets.only(left: 8.25),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child:
                                  "Quantity".text.color(textfieldGrey).make(),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.remove)),
                                // 6.widthBox,
                                "0"
                                    .text
                                    .size(16)
                                    .color(darkFontGrey)
                                    .fontFamily(bold)
                                    .make(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add)),
                                6.widthBox,
                                "0 available"
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

                      Padding(
                        padding: const EdgeInsets.only(left: 8.25),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Total".text.color(textfieldGrey).make(),
                            ),
                            Row(
                              children: [
                                "\$0.00"
                                    .text
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
                  10.heightBox,
                  "Description"
                      .text
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .make(),
                  10.heightBox,
                  "This is a dummy item and dummy description here..."
                      .text
                      .color(textfieldGrey)
                      .make(),
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
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
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
                onPress: () {},
                width: 500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
