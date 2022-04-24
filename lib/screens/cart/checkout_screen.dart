import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/api/cart.dart';
import 'package:shop_app/api/invoice.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/All.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/cart/components/check_out_card.dart';
import 'package:shop_app/screens/cart/components/checkout_form.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/shared_preferences.dart';
import 'package:shop_app/size_config.dart';

class CheckoutScreen extends StatelessWidget {
  static String routeName = "/checkout";

  late List<Cart> listCarts;

  @override
  Widget build(BuildContext context) {
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
                CheckoutForm checkoutForm = CheckoutForm();
                // int _sum = context.watch<Calculate>().sum +
                //     Fee.transport(context.watch<Calculate>().weight) +
                //     Fee.bond(context.watch<Calculate>().sum);
                return Scaffold(
                  appBar: buildAppBar(context),
                  body: checkoutForm,
                  // Bottom
                  bottomNavigationBar: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenWidth(15),
                      horizontal: getProportionateScreenWidth(30),
                    ),
                    // height: 174,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, -15),
                          blurRadius: 20,
                          color: Color(0xFFDADADA).withOpacity(0.15),
                        )
                      ],
                    ),
                    child: SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: getProportionateScreenHeight(20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: "Tổng cộng:\n",
                                  children: [
                                    TextSpan(
                                      text:
                                          "${numberWithDot((context.watch<Calculate>().sum + Fee.transport(context.watch<Calculate>().weight) + Fee.bond(context.watch<Calculate>().sum)).toString())}đ",
                                      // '0đ',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(190),
                                child: DefaultButton(
                                  text: "Đặt hàng",
                                  press: () async {
                                    // print(checkoutForm.addressText.text);
                                    // print(checkoutForm.noteText.text);
                                    String res =
                                        'Có lỗi xảy ra, vui lòng thử lại!';
                                    if (context.watch<Calculate>().num > 0) {
                                      bool _postInvoice = await postInvoice(
                                          BaseSharedPreferences.getString(
                                              'user_id'),
                                          checkoutForm.fullnameText.text,
                                          checkoutForm.phoneNumberText.text,
                                          checkoutForm.emailText.text,
                                          checkoutForm.addressText.text,
                                          checkoutForm.noteText.text);
                                      if (_postInvoice)
                                        res =
                                            'Đặt hàng thành công! Vui lòng kiểm tra đơn hàng và thanh toán.';
                                    }
                                    _dismissDialog() {
                                      Navigator.pop(context);
                                    }

                                    showDialog(
                                        context: context,
                                        builder: (contextB) {
                                          return AlertDialog(
                                            title: Text('Thông báo'),
                                            content: Text(res),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  _dismissDialog();
                                                  Navigator.pushNamed(context,
                                                      HomeScreen.routeName);
                                                },
                                                child: Text('Đóng'),
                                              ),
                                            ],
                                          );
                                        });
                                    // Navigator.pushNamed(
                                    //     context, CheckoutScreen.routeName);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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
            "Đặt hàng",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            'Chuẩn bị chốt đơn nè',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
