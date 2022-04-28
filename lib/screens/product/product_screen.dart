import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';

import 'components/body.dart';

class ProductScreen extends StatelessWidget {
  static String routeName = "/product";

  @override
  Widget build(BuildContext context) {
    final ProductArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductArguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Body(keyword: agrs.keyword),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.product),
    );
  }
}

class ProductArguments {
  ProductArguments({required this.keyword});
  String keyword = '';
}
