// To parse this JSON data, do
//
//     final categorymode = categorymodeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Categorymode categorymodeFromJson(String str) => Categorymode.fromJson(json.decode(str));

// String categorymodeToJson(Categorymode data) => json.encode(data.toJson());

class Categorymode {
    List<Category> categories;

    Categorymode({
        required this.categories,
    });

    factory Categorymode.fromJson(Map<String, dynamic> json) => Categorymode(
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    
}

class Category {
    String name;
    List<String> subcategory;

    Category({
        required this.name,
        required this.subcategory,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subcategory: List<String>.from(json["subcategory"].map((x) => x)),
    );

    
}
