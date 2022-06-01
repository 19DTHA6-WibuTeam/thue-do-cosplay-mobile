import 'package:flutter/material.dart';
import 'package:shop_app/api/invoice.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/All.dart';
import 'package:shop_app/screens/invoice/invoice_details.dart';
import 'package:shop_app/shared_preferences.dart';
import 'package:shop_app/size_config.dart';

class BodyInvoices extends StatefulWidget {
  @override
  State<BodyInvoices> createState() => _BodyInvoicesState();
}

class _BodyInvoicesState extends State<BodyInvoices> {
  int _page = 1;
  int _limit = 10;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List<Invoice> _invoices = [];

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await getInvoices(
          BaseSharedPreferences.getString('user_id'), _page, _limit);
      setState(() {
        _invoices = res!;
      });
    } catch (err) {
      print(err);
      print('Something went wrongg');
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // This function will be triggered whenver the user scroll
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        final res = await getInvoices(
            BaseSharedPreferences.getString('user_id'), _page, _limit);

        final List<Invoice> fetchedInvoices = res!;
        if (fetchedInvoices.length > 0) {
          setState(() {
            _invoices.addAll(fetchedInvoices);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = new ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenWidth(10)),
          _isFirstLoadRunning
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: GridView.count(
                    // shrinkWrap: true,
                    padding: EdgeInsets.all(18.0),
                    childAspectRatio: 6,
                    crossAxisCount: 1,
                    children: [
                      ...List.generate(
                        _invoices.length,
                        (index) {
                          // return ProductCard(product: _invoices[index]);
                          return GestureDetector(
                              onTap: () {
                                // InvoiceDetailsScreen(
                                //     invoiceId: _invoices[index].invoice_id);
                                Navigator.pushNamed(
                                    context, InvoiceDetailsScreen.routeName,
                                    arguments: InvoiceDetailsArguments(
                                        invoice: _invoices[index]));
                              },
                              child: Text(
                                  'Ngày ${unixToDate(int.parse(_invoices[index].invoice_created_at) * 1000)}: mã đơn hàng #INV${_invoices[index].invoice_id}'));
                        },
                      ),
                      // SizedBox(width: getProportionateScreenWidth(20)),
                    ],
                  ),
                ),
          if (_isLoadMoreRunning == true)
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 40),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          SizedBox(height: getProportionateScreenWidth(30)),
        ],
      ),
      // ),
    );
  }
}
