
import 'package:emart_app/CategoryScreen/category_screen.dart';
import 'package:emart_app/cart_screen/CartScreen.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/images.dart';
import 'package:emart_app/consts/strings.dart';
import 'package:emart_app/controller/home_controller.dart';
import 'package:emart_app/home_screen/homescreen.dart';
import 'package:emart_app/profile_screen/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: must_be_immutable
class Home extends StatelessWidget {
  var controller = Get.put(HomeController());

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account),
    ];

    var navBody = [
      Homescreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: Column(
        children: [
          Obx(() => (Expanded(
            child: navBody.elementAt(controller.currentNavIndex.value)))),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: redColor,
          selectedLabelStyle: TextStyle(fontFamily: semibold),
          items: navbarItem,
          backgroundColor: Colors.white,
          onTap: (value) {
            controller.currentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}
