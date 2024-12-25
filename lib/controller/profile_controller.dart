import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/consts/firebase_const.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImgPath = ''.obs;
  var profileImagelink = '';
  var isloading = false.obs;
  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();
  changeImage(context) async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      if (img == null) {
        return;
      }
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var filename = basename(profileImgPath.value);
    var destination = 'images/${user!.uid}/$filename';

    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImagelink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imgurl}) async {
    var store =
        FirebaseFirestore.instance.collection(userCollection).doc(user!.uid);
    await store.set({
      'name': name,
      'password': password,
      'imgurl': imgurl,
    }, SetOptions(merge: true));
    isloading(false);
  }

  changeAuthPassword({email, password,newpassword})async
  {
    final cred=EmailAuthProvider.credential(email: email, password: password);

    await user!.reauthenticateWithCredential(cred).then((value)=>{
      user!.updatePassword(newpassword),
    }).catchError((error){
      print(error.toString());
    });
  }
}
