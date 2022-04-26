import 'package:flutter/material.dart';
import 'package:shop_app/models/All.dart';

import 'components/checkout_form.dart';

class CheckoutInvoiceScreen extends StatelessWidget {
  static String routeName = "/checkout_invoice";

  @override
  Widget build(BuildContext context) {
    final CheckoutInvoiceArguments agrs =
        ModalRoute.of(context)!.settings.arguments as CheckoutInvoiceArguments;

    return Scaffold(
      appBar: buildAppBar(context),
      body: CheckoutForm(invoice: agrs.invoice),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Thanh toán",
            style: TextStyle(color: Colors.black),
          ),
          // Text(
          //   'Chuẩn bị chốt đơn nè',
          //   style: Theme.of(context).textTheme.caption,
          // ),
        ],
      ),
    );
  }
}

class CheckoutInvoiceArguments {
  final Invoice invoice;

  CheckoutInvoiceArguments({required this.invoice});
}
