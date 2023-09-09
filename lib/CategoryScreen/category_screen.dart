import 'package:emart_app/CategoryScreen/categorydetails.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/strings.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/widgets/bg_widget.dart';
import 'package:emart_app/widgets/list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
  var controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: categories.text.fontFamily(bold).make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                mainAxisExtent: 200,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(
                      categoriesimage[index],
                      height: 100,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    categoryList[index]
                        .text
                        .color(darkFontGrey)
                        .align(TextAlign.center)
                        .make(),
                  ],
                )
                    .box
                    .white
                    .roundedSM
                    .clip(Clip.antiAlias)
                    .outerShadowSm
                    .make()
                    .onTap(() {
                  controller.getsubcategories(categoryList[index]);
                  Get.to(() => CategoryDetails(title: categoryList[index]));
                });
              }),
        ),
      ),
    );
  }
}
