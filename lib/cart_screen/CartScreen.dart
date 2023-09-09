import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

import '../consts/colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    child: "Cart is empty".text.color(darkFontGrey).fontFamily(semibold).size(18).makeCentered(),
    );
  }
}
