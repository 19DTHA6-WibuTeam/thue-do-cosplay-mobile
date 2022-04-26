import 'package:flutter/material.dart';
import 'package:shop_app/api/user.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/models/All.dart';
import 'package:shop_app/shared_preferences.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutForm extends StatelessWidget {
  CheckoutForm({required this.invoice});
  Invoice invoice;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Chuyển khoản vào một trong những kênh ví điện tử hoặc ngân hàng bên dưới với nội dung:\nWIBUSHOP INV${invoice.invoice_id}\n\nShop sẽ kiểm tra trong ngày cho bạn. Nếu có trục trặc shop sẽ liên hệ qua số điện thoại trên tài khoản/đơn hàng để giải quyết.",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text(
                  "MOMO: 0777 xxx 449",
                  textAlign: TextAlign.center,
                ),
                Image.network(
                  'https://wibuteam.phatdev.xyz/assets/payment/momo.jpg',
                  width: 250,
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text(
                  "Vetcombank: 053 xxx 258 9292",
                  textAlign: TextAlign.center,
                ),
                Image.network(
                  'https://wibuteam.phatdev.xyz/assets/payment/vcb.jpg',
                  width: 250,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
