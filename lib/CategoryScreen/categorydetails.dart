import 'package:emart_app/CategoryScreen/item_details.dart';
import 'package:emart_app/CategoryScreen/loading_Indicator.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/controller/services/firestore_services.dart';
import 'package:emart_app/widgets/bg_widget.dart';
import 'package:emart_app/widgets/list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  CategoryDetails({super.key, required this.title});
  var controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(
                    controller.subcat.length,
                    (index) => "${controller.subcat[index]}"
                        .text
                        .size(12)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .makeCentered()
                        .box
                        .white
                        .rounded
                        .size(120, 60)
                        .margin(EdgeInsets.symmetric(horizontal: 4.00))
                        .make(),
                  )),
                ),
                20.heightBox,
                Expanded(
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 250),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            imgP5,
                            width: 190,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          // Spacer(),
                          "Laptop 4GB/64GB"
                              .text
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),
                          10.heightBox,
                          "\$600"
                              .text
                              .fontFamily(bold)
                              .size(16)
                              .color(redColor)
                              .make()
                        ],
                      )
                          .box
                          .white
                          .roundedSM
                          .outerShadow
                          .margin(EdgeInsets.symmetric(horizontal: 4))
                          .padding(EdgeInsets.all(12))
                          .make();
                    },
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
