
import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/home_header.dart';

import '../../../size_config.dart';
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
