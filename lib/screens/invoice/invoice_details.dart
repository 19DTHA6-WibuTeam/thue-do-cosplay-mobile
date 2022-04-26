import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/api/cart.dart';
import 'package:shop_app/api/invoice.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/All.dart';
import 'package:shop_app/shared_preferences.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  static String routeName = "/invoice_details";

  // InvoiceDetailsScreen({required this.invoiceId});
  @override
  Widget build(BuildContext context) {
    final InvoiceDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as InvoiceDetailsArguments;
    List<InvoiceDetails> invoiceDetails = [];

    // return Scaffold(
    //   appBar: buildAppBar(context),
    //   body: body,
    //   bottomNavigationBar: CheckoutCard(),
    // );

    // return ChangeNotifierProvider<Calculate>(
    //   create: (context) => Calculate(carts: listInvoiceDetails),
    //   child: FutureBuilder<List<Cart>?>(
    //     future: getCarts(BaseSharedPreferences.getString('user_id')),
    //     builder: (context, AsyncSnapshot<List<Cart>?> snapshot) {
    //       switch (snapshot.connectionState) {
    //         case ConnectionState.waiting:
    //           return Text('Loading...');
    //         default:
    //           if (snapshot.hasError) {
    //             print('Error: ${snapshot.error}');
    //             return Text('Wut.');
    //           } else {
    //             listInvoiceDetails = snapshot.data!;
    //             Provider.of<Calculate>(context, listen: false).update();
    //             return Scaffold(
    //               appBar: buildAppBar(context),
    //               body: Body(carts: listInvoiceDetails),
    //               bottomNavigationBar: CheckoutCard(),
    //             );
    //           }
    //       }
    //     },
    //   ),
    // );

    return FutureBuilder<List<InvoiceDetails>?>(
      future: getInvoiceDetails(agrs.invoice.invoice_id),
      builder: (context, AsyncSnapshot<List<InvoiceDetails>?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            // return Text('Loading...');
            // return Scaffold(
            //   body: Text('Loading...'),
            // );
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError) {
              print('Error: ${snapshot.error}');
              // return Text('Wut.');
              return Scaffold(
                appBar: buildAppBar(context),
                body: Text('Wut.'),
                // bottomNavigationBar: CheckoutCard(invoice: agrs.invoice),
              );
            } else {
              invoiceDetails = snapshot.data!;
              // Provider.of<Calculate>(context, listen: false).update();
              // context.read<Calculate>().update();
              return Scaffold(
                appBar: buildAppBar(context),
                body: Body(invoiceDetails: invoiceDetails),
                bottomNavigationBar: CheckoutCard(invoice: agrs.invoice),
              );
            }
        }
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Chi tiết đơn hàng",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class InvoiceDetailsArguments {
  final Invoice invoice;

  InvoiceDetailsArguments({required this.invoice});
}
