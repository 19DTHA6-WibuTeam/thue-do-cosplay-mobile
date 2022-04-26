import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/All.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../checkout_screen.dart';

class CheckoutCard extends StatelessWidget {
  CheckoutCard({required this.invoice});
  Invoice invoice;

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
                          'Tạm tính: ${numberWithDot(invoice.invoice_subtotal.toString())}đ\n' +
                              'Phí vận chuyển: ${numberWithDot(invoice.invoice_fee_transport.toString())}đ\n' +
                              'Phí đảm bảo tài sản: ${numberWithDot(invoice.invoice_fee_bond.toString())}đ\n\n' +
                              'Xem thêm thông tin tại Website.',
                          // '',
                        ),
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
                            "${numberWithDot((invoice.invoice_subtotal + invoice.invoice_fee_transport + invoice.invoice_fee_bond).toString())}đ",
                        // '0đ',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: orderStatus(invoice.invoice_status),
                    press: () {
                      if (invoice.invoice_status == 1)
                        Navigator.pushNamed(
                            context, CheckoutInvoiceScreen.routeName,
                            arguments:
                                CheckoutInvoiceArguments(invoice: invoice));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
