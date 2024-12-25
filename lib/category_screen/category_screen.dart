import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycart/category_screen/category_details.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/controller/product_controller.dart';
import 'package:mycart/widget_common/bg_widget.dart';
import 'package:mycart/widget_common/list.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      body: bgWidget(
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: categories.text.fontFamily(bold).size(20).white.make(),
          ),
          body: Container(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: catagoriesList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 0,
                mainAxisExtent: 200,
              ),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      catagoriesimages[index],
                      width: 200,
                      height: 115,
                      fit: BoxFit.cover,
                    ),
                    10.heightBox,
                    catagoriesList[index]
                        .text
                        .size(5)
                        .color(darkFontGrey)
                        .align(TextAlign.center)
                        .make(),
                  ],
                )
                    .box
                    .white
                    .margin(
                      const EdgeInsets.symmetric(horizontal: 4),
                    )
                    .roundedSM
                    .padding(const EdgeInsets.all(12))
                    .make()
                    .onTap(
                  () {
                    controller.getSubCategories(catagoriesList[index]);

                    Get.to(() => CatagoryDetails(
                          title: catagoriesList[index],
                        ));
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
