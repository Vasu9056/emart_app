import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/home_screen/component/featured_buttons.dart';
import 'package:emart_app/widgets/home_buttons.dart';
import 'package:emart_app/widgets/list.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(children: [
        Container(
          height: 60,
          alignment: Alignment.center,
          color: lightGrey,
          child: TextFormField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: whiteColor,
                hintText: searchanything,
                suffixIcon: Icon(Icons.search)),
          ),
        ),
        10.heightBox,

        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    height: 150,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    itemCount: brandsList.length,
                    itemBuilder: (context, index) {
                      return Container(
                          child: Image.asset(
                        brandsList[index],
                        fit: BoxFit.fill,
                      )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make());
                    }),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    2,
                    (index) => homeButtons(
                      height: context.screenHeight * 0.15,
                      width: context.screenWidth / 2.5,
                      icon: index == 0 ? icTodaysDeal : icFlashDeal,
                      title: index == 0 ? todayDeal : flashsale,
                    ),
                  ),
                ),
                8.heightBox,
                VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    height: 150,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    itemCount: brandsList2.length,
                    itemBuilder: (context, index) {
                      return Container(
                          child: Image.asset(
                        brandsList2[index],
                        fit: BoxFit.fill,
                      )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make());
                    }),
                8.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    3,
                    (index) => homeButtons(
                        height: context.screenHeight * 0.15,
                        width: context.screenWidth / 3.5,
                        icon: index == 0
                            ? icTopCategories
                            : index == 1
                                ? icBrands
                                : icTopSeller,
                        title: index == 0
                            ? topCategories
                            : index == 1
                                ? brand
                                : topSellers),
                  ),
                ),
                15.heightBox,
                Align(
                  alignment: Alignment.centerLeft,
                  child: "Featured Categories"
                      .text
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .size(18)
                      .make(),
                ),
                20.heightBox,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        3,
                        (index) => Column(
                              children: [
                                FeatureButton(
                                    title: featuretitle1[index],
                                    icon: featureImage1[index]),
                                10.heightBox,
                                FeatureButton(
                                    title: featuretitle2[index],
                                    icon: featureImage2[index])
                              ],
                            )).toList(),
                  ),
                ),
                15.heightBox,
                Container(
                  padding: EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(color: redColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      featureproduct.text.white
                          .fontFamily(bold)
                          .size(18)
                          .make(),
                      10.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: List.generate(
                                6,
                                (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          imgP1,
                                          width: 130,
                                          fit: BoxFit.cover,
                                        ),
                                        10.heightBox,
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
                                        .margin(
                                            EdgeInsets.symmetric(horizontal: 4))
                                        .padding(EdgeInsets.all(8))
                                        .make())),
                      )
                    ],
                  ),
                ),
                15.heightBox,
                // swiper
                VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    height: 150,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    itemCount: brandsList2.length,
                    itemBuilder: (context, index) {
                      return Container(
                          child: Image.asset(
                        brandsList2[index],
                        fit: BoxFit.fill,
                      )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make());
                    }),

                15.heightBox,
                GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            mainAxisExtent: 300),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            imgP5,
                            width: 190,
                            height: 190,
                            fit: BoxFit.cover,
                          ),
                          Spacer(),
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
                          .margin(EdgeInsets.symmetric(horizontal: 4))
                          .padding(EdgeInsets.all(12))
                          .make();
                    })
              ],
            ),
          ),
        )

        //swiper
      ])),
    );
  }
}
