import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/api/cart.dart';
import 'package:shop_app/models/All.dart';
import 'package:shop_app/shared_preferences.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  late List<Cart> listCarts;

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: buildAppBar(context),
    //   body: body,
    //   bottomNavigationBar: CheckoutCard(),
    // );

    return ChangeNotifierProvider<Calculate>(
      create: (context) => Calculate(carts: listCarts),
      child: FutureBuilder<List<Cart>?>(
        future: getCarts(BaseSharedPreferences.getString('user_id')),
        builder: (context, AsyncSnapshot<List<Cart>?> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
                return Text('Wut.');
              } else {
                listCarts = snapshot.data!;
                Provider.of<Calculate>(context, listen: false).update();
                return Scaffold(
                  appBar: buildAppBar(context),
                  body: Body(carts: listCarts),
                  bottomNavigationBar: CheckoutCard(),
                );
              }
          }
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Giỏ hàng nè",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${context.watch<Calculate>().num} items",
            // 'Lướt sản phẩm qua trái để xoá',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}

class Calculate with ChangeNotifier {
  Calculate({required this.carts});

  List<Cart> carts;
  int _sum = 0;
  int _num = 0;
  int _weight = 0;

  int get sum => _sum;
  int get num => _num;
  int get weight => _weight;

  void update() {
    _sum = 0;
    _num = carts.length;
    for (var cart in carts) {
      _sum += cart.cart_product_quantity * cart.product_rental_price;
      _weight += cart.cart_product_quantity * cart.product_weight;
    }
    notifyListeners();
  }
}
