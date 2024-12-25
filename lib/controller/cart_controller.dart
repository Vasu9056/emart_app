import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycart/consts/firebase_const.dart';
import 'package:mycart/controller/home_controller.dart';

class CartController extends GetxController {
  var totalP = 0.0.obs;
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var pinCodeController = TextEditingController();
  var phoneController = TextEditingController();
  var placingOrder = false.obs;
  var product = [];
  var india = "+91";
  late dynamic productSnapshot;
  var paymentIndex = 0.obs;

  calculate(List<dynamic> data) {
    totalP.value = 0.0;
    for (var i = 0; i < data.length; i++) {
      totalP.value += double.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);
    await getProductDetails();

    await firestore.collection(orderCollection).doc().set({
      'order_code': "1234567890",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': user!.uid,
      'order_by_name': Get.find<HomeController>().username.value,
      'order_by_email': user!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text.capitalizeFirst,
      'order_by_city': cityController.text.capitalizeFirst,
      'order_by_phone': phoneController.text,
      'order_by_PinCode': pinCodeController.text,
      'Shipping_method': "Home Delivery",
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'order_placed': true,
      'total_amount': totalAmount,
      'payment_method': orderPaymentMethod,
      'orders': FieldValue.arrayUnion(product),
    });

    await clearCart();
    placingOrder(false);
  }

  getProductDetails() {
    product.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      product.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'qty': productSnapshot[i]['qty'],
        'tprice': productSnapshot[i]['tprice'],
        'title': productSnapshot[i]['title'],
        'vendor_id': productSnapshot[i]['vendor_id'],
      });
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
