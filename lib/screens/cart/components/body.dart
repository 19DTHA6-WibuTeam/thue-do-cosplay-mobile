import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/api/cart.dart';
import 'package:shop_app/models/All.dart';
import 'package:shop_app/shared_preferences.dart';

import '../../../size_config.dart';
import '../cart_screen.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  Body({Key? key, required this.carts}) : super(key: key);

  List<Cart> carts;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      // child: ListView.builder(
      //   itemCount: [].length,
      //   itemBuilder: (context, index) => Padding(
      //     padding: EdgeInsets.symmetric(vertical: 10),
      //     child: Dismissible(
      //       key: Key([][index].product.product_id),
      //       direction: DismissDirection.endToStart,
      //       onDismissed: (direction) {
      //         setState(() {
      //           [].removeAt(index);
      //         });
      //       },
      //       background: Container(
      //         padding: EdgeInsets.symmetric(horizontal: 20),
      //         decoration: BoxDecoration(
      //           color: Color(0xFFFFE6E6),
      //           borderRadius: BorderRadius.circular(15),
      //         ),
      //         child: Row(
      //           children: [
      //             Spacer(),
      //             SvgPicture.asset("assets/icons/Trash.svg"),
      //           ],
      //         ),
      //       ),
      //       child: CartCard(cart: [][index]),
      //     ),
      //   ),
      // ),

      // child: FutureBuilder<List<Cart>?>(
      //     future: getCarts(BaseSharedPreferences.getString('user_id')),
      //     builder: (BuildContext context, AsyncSnapshot<List<Cart>?> snapshot) {
      //       switch (snapshot.connectionState) {
      //         case ConnectionState.waiting:
      //           return Text('Loading...');
      //         default:
      //           if (snapshot.hasError) {
      //             print('Error: ${snapshot.error}');
      //             return Text('Wut.');
      //           } else {
      //             List<Cart>? carts = snapshot.data;
      //             return ListView.builder(
      //               itemCount: carts!.length,
      //               itemBuilder: (context, index) => Padding(
      //                 padding: EdgeInsets.symmetric(vertical: 10),
      //                 child: Dismissible(
      //                   key: Key(carts[index].product_id),
      //                   direction: DismissDirection.endToStart,
      //                   onDismissed: (direction) {
      //                     setState(() {
      //                       carts.removeAt(index);
      //                     });
      //                   },
      //                   background: Container(
      //                     padding: EdgeInsets.symmetric(horizontal: 20),
      //                     decoration: BoxDecoration(
      //                       color: Color(0xFFFFE6E6),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                     child: Row(
      //                       children: [
      //                         Spacer(),
      //                         SvgPicture.asset("assets/icons/Trash.svg"),
      //                       ],
      //                     ),
      //                   ),
      //                   child: CartCard(cart: carts[index]),
      //                 ),
      //               ),
      //             );
      //           }
      //       }
      //     }),

      child: ListView.builder(
        itemCount: widget.carts.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: ClipRect(
            child: Dismissible(
              // key: Key(widget.carts[index].product_id),
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _dismissDialog() {
                  Navigator.pop(context);
                }

                showDialog(
                    context: context,
                    builder: (newContext) {
                      return AlertDialog(
                        title: Text('Thông báo'),
                        content: Text('Bạn có muốn xoá mặt hàng này không?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              _dismissDialog();
                              setState(() {});
                            },
                            child: Text('Ko'),
                          ),
                          TextButton(
                            onPressed: () async {
                              _dismissDialog();
                              bool a = await deleteCart(
                                  BaseSharedPreferences.getString('user_id'),
                                  widget.carts[index].product_id);
                              if (a == true) {
                                setState(() {
                                  widget.carts.removeAt(index);
                                  Provider.of<Calculate>(context, listen: false)
                                      .update();
                                });
                              }
                            },
                            child: Text('Kó'),
                          ),
                        ],
                      );
                    });
              },
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    SvgPicture.asset("assets/icons/Trash.svg"),
                  ],
                ),
              ),
              child: CartCard(cart: widget.carts[index]),
            ),
          ),
        ),
      ),
    );
  }
}
