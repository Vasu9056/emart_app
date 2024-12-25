import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/consts/firebase_const.dart';

class AuthController extends GetxController {
  var isloading = false.obs;

  Future<UserCredential?> login({email, password, context}) async {
    UserCredential? usercrenditial;
    try {
      usercrenditial = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message.toString());
    }
    return usercrenditial;
  }

  //signup

  Future<UserCredential?> signup({email, password, context}) async {
    UserCredential? usercredential;

    try {
      usercredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }

    return usercredential;
  }

  //storing data
  storeUserdata({name, email, password}) async {
    DocumentReference store =
        firestore.collection(userCollection).doc(user!.uid);
    store.set({
      'name': name,
      'password': password,
      'imgurl': '',
      'email': email,
      'id': user!.uid,
      'cart_count': "00",
      'Order_count': "00",
      'wishlist_count': "00"
    });
  }

  //signout
  signout({context}) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
