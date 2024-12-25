import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mycart/category_model/category_model.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/consts/firebase_const.dart';

class ProductController extends GetxController {
  var subcat = [];
  var quantity = 0.obs;
  var totalPrice = 0.obs;
  var colorIndex = 0.obs;
  var isFav = false.obs;

  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString('lib/services/category_model.json');

    var decoded = categoryModelFromJson(data);

    var s = decoded.categories.where((element) => element.name == title).toList();

    if (s.isNotEmpty) {
      for (var e in s[0].subcategory) {
        subcat.add(e);
      }
    }
  }

  changeColorIndex(index) {
    colorIndex.value = index;
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart({title, img, sellername, color, qty, tprice, context, vendorId}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'qty': qty,
      'tprice': tprice,
      'added_by': user!.uid,
      'vendor_id': vendorId
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
  }

  addToWishlist(String docId, context) async {
    await firestore.collection(productCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([user!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context,
        msg: "Add to Wishlist",
        bgColor: redColor,
        textColor: whiteColor,
        position: VxToastPosition.center);
  }

  removeFromWishlist(String docId, context) async {
    await firestore.collection(productCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([user!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context,
        msg: "Remove to Wishlist",
        bgColor: redColor,
        textColor: whiteColor,
        position: VxToastPosition.center);
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contains(user!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
