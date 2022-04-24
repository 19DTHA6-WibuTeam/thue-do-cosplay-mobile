import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/api/product.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/All.dart';

import '../../../size_config.dart';
import 'home_header.dart';
import 'special_offers.dart';
// import 'popular_product.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          HomeHeader(),
          SizedBox(height: getProportionateScreenWidth(10)),
          SpecialOffers(),
          SizedBox(height: getProportionateScreenWidth(30)),
        ],
      ),
      // ),
    );
  }
}
