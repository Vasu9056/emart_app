import 'package:emart_app/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:emart_app/models/category_model.dart';

class ProductController extends GetxController {
  var subcat = [];

  getsubcategories(title) async {
    subcat.clear();
    var data = await rootBundle
        .loadString("lib/controller/services/category_model.json");
    var decoded = categorymodeFromJson(data);

    var s =
        decoded.categories.where((element) => element.name == title).toList();

    if (s.isNotEmpty) {
      subcat.assignAll(s[0].subcategory);
    } else {
      print("No category matching");
    }
  }
}
