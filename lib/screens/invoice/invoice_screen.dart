import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/screens/invoice/components/body_invoices.dart';

class InvoiceScreen extends StatelessWidget {
  static String routeName = "/invoice";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "Danh sách đơn hàng",
              style: TextStyle(color: Colors.black),
            ),
            // Text(
            //   'Lướt sản phẩm qua trái để xoá',
            //   style: Theme.of(context).textTheme.caption,
            // ),
          ],
        ),
      ),
      body: BodyInvoices(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
