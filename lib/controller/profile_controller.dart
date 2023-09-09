import 'dart:io';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/firebase_consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProfileController extends GetxController {
  var profileImgpath = ''.obs;
  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();
  var profileImagelink = '';
  var isloading = false.obs;

  changeImage(context) async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      if (img == null) return;
      profileImgpath.value = img.path;
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var filename = basename(profileImgpath.value);
    var destination = 'images/${currentUser!.uid}/$filename';

    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgpath.value));
    profileImagelink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imgurl}) async {
    var store = FirebaseFirestore.instance.collection(usercollection).doc(currentUser!.uid);
    await store.set({
      'name': name,
      'password': password,
      'imgurl': imgurl,
    }, SetOptions(merge: true));
    isloading(false);
  }

  changeAuthpassword({email, password, newpassword}) async {
    
      final cred = EmailAuthProvider.credential(email: email, password: password);
      await currentUser!.reauthenticateWithCredential(cred);
      await currentUser!.updatePassword(newpassword);
    } catcherror (error) {
      print(error.toString());
    }
  }

const usercollection = 'users'; // Define 'usercollection' if not already defined.
