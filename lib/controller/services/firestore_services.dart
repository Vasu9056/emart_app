import 'package:emart_app/consts/consts.dart';

class FireStoreServices{

  //for get user data 
  static getUser(uid)
  {
    return firestore.collection(usercollection).where('id',isEqualTo:uid).snapshots();
  }

  static getproducts(String? title)
  {
    return firestore.collection(productscollection).where('p_category', isEqualTo:categories).snapshots();
  }
}