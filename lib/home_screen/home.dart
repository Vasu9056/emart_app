import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycart/cart_screen/cart_screen.dart';
import 'package:mycart/category_screen/category_screen.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/controller/home_controller.dart';
import 'package:mycart/home_screen/home_screen.dart';
import 'package:mycart/profile_screen/profile_screen.dart';
import 'package:mycart/widget_common/exit_dialog.dart';

class Home extends StatelessWidget {
  Home({super.key});
  var controller=Get.put(HomeController());
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
      ProfileScreen()
    ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context, 
          builder: (context) => exitDialog(context)
        );
        return false;
      },
      child: Scaffold(
        body:Column(
          children: [
            Expanded(child: Obx(()=>navBody[controller.currentNavIndex.value])),
          ],
        ),
        bottomNavigationBar: Obx(()=>
           BottomNavigationBar(items: navbarItem,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: redColor,
          currentIndex: controller.currentNavIndex.value,
          selectedLabelStyle: const TextStyle(fontFamily: semibold),
          onTap: (value){
            controller.currentNavIndex.value=value;
          },
          ),
        ),
      ),
    );
  }
}

