import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/cart/checkout_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            InkWell(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: getProportionateScreenWidth(40),
                    width: getProportionateScreenWidth(40),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg"),
                  ),
                  Spacer(),
                  Text("(Đã bao gồm các phí)"),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kTextColor,
                  ),
                ],
              ),
              onTap: () {
                // print("Tapped on container");
                _dismissDialog() {
                  Navigator.pop(context);
                }

                showDialog(
                    context: context,
                    builder: (contextB) {
                      return AlertDialog(
                        title: Text('Thông báo'),
                        content: Text(
                            'Tạm tính: ${numberWithDot(context.watch<Calculate>().sum.toString())}đ\n' +
                                'Phí vận chuyển: ${numberWithDot(Fee.transport(context.watch<Calculate>().weight).toString())}đ\n' +
                                'Phí đảm bảo tài sản: ${numberWithDot(Fee.bond(context.watch<Calculate>().sum).toString())}đ\n\n' +
                                'Xem thêm thông tin tại Website.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              _dismissDialog();
                            },
                            child: Text('Đóng'),
                          ),
                        ],
                      );
                    });
              },
            ),
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
                            "${context.watch<Calculate>().num > 0 ? numberWithDot((context.watch<Calculate>().sum + Fee.transport(context.watch<Calculate>().weight) + Fee.bond(context.watch<Calculate>().sum)).toString()) : '0'}đ",
                        // '0đ',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Tiếp tục",
                    press: () {
                      if (context.read<Calculate>().num > 0) {
                        Navigator.pushNamed(context, CheckoutScreen.routeName);
                      } else
                        showDialog(
                            context: context,
                            builder: (contextB) {
                              return AlertDialog(
                                title: Text('Thông báo'),
                                content: Text('Giỏ hàng của bạn đang trống!'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, HomeScreen.routeName);
                                    },
                                    child: Text('Đóng'),
                                  ),
                                ],
                              );
                            });
                    },
                  ),
                ),
              ],
              // children: [
              //   Consumer<Calculate>(
              //     builder: (context, mymodel, child) {
              //       return Text.rich(
              //         TextSpan(
              //           text: "Tổng cộng:\n",
              //           children: [
              //             TextSpan(
              //               text: "${numberWithDot(mymodel.sum.toString())}đ",
              //               style:
              //                   TextStyle(fontSize: 16, color: Colors.black),
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              //   SizedBox(
              //     width: getProportionateScreenWidth(190),
              //     child: DefaultButton(
              //       text: "Chốt đơn",
              //       press: () {},
              //     ),
              //   ),
              // ],
            ),
          ],
        ),
      ),
    );
  }
}
