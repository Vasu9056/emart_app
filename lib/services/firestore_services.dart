import 'package:mycart/consts/firebase_const.dart';

class FirestoreServices {
  static getUser(uid) {
    return firestore.collection(userCollection).where('id', isEqualTo: uid).snapshots();
  }

  static getProducts(category) {
    return firestore.collection(productCollection).where('p_category', isEqualTo: category).snapshots();
  }

  static getCart(uid) {
    return firestore.collection(cartCollection).where('added_by', isEqualTo: uid).snapshots();
  }

  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  static getChatMessages(docId) {
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(messageCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  
  static getAllOrder() {
    return firestore
        .collection(orderCollection)
        .where('order_by', isEqualTo: user!.uid)
        .snapshots();
  }

  static getWishList() {
    return firestore
        .collection(productCollection)
        .where('p_wishlist', arrayContains: user!.uid)
        .snapshots();
  }


static getAllMessages() {
    return firestore
        .collection(chatCollection)
        .where('from_id', isEqualTo: user!.uid)
        .snapshots();
  }

  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where('added_by', isEqualTo: user!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productCollection)
          .where('p_wishlist', arrayContains: user!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(orderCollection)
          .where('order_by', isEqualTo: user!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static getAllProduct() {
    return firestore.collection(productCollection).snapshots();
  }

  static getAllFeaturedProduct() {
    return firestore
        .collection(productCollection)
        .where('isFeatured', isEqualTo: true)
        .get();
  }

  static searchProduct() {
    return firestore.collection(productCollection).get();
  }

  static getSubCategory(title) {
    return firestore
        .collection(productCollection)
        .where('p_subcategory', isEqualTo: title)
        .snapshots();
  }

   static getProduct(category) {
    return firestore
        .collection(productCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }
}

