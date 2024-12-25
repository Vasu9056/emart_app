import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycart/consts/firebase_const.dart';
class HomeController extends GetxController {
  var currentNavIndex = 0.obs;
  var username = ''.obs;
  var searchController=TextEditingController();
  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  getUsername() async {
    var n = await firestore.collection(userCollection).where('id', isEqualTo: user!.uid).get().then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username.value = n;
  }
}