import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/api/cart.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/All.dart';
import 'package:shop_app/shared_preferences.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  Body({Key? key, required this.invoiceDetails}) : super(key: key);

  List<InvoiceDetails> invoiceDetails;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: widget.invoiceDetails.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: ClipRect(
            child: Dismissible(
              // key: Key(widget.carts[index].product_id),
              key: UniqueKey(),
              direction: DismissDirection.none,
              onDismissed: (direction) {
                setState(() {});
              },
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                // child: Row(
                //   children: [
                //     Spacer(),
                //     SvgPicture.asset("assets/icons/Trash.svg"),
                //   ],
                // ),
              ),
              child: CartCard(cart: widget.invoiceDetails[index]),
            ),
          ),
        ),
      ),
    );
  }
}
