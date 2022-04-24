import 'package:flutter/material.dart';
import 'package:shop_app/api/cart.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/All.dart';
import 'package:shop_app/shared_preferences.dart';
// import 'package:shop_app/models/Product.dart';
import 'package:shop_app/size_config.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorDots colorDots = ColorDots(product: product);
    // ColorDots _colorDots = new ColorDots(product: product);
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    colorDots,
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Thêm vào giỏ hàng",
                          press: () async {
                            bool addToCart = await postCart(
                                BaseSharedPreferences.getString('user_id'),
                                product.product_id,
                                colorDots.quantity);
                            String noti = '';
                            if (addToCart == true)
                              noti = 'Đã thêm vào giỏ hàng!';
                            else
                              noti = 'Không thể thêm vào giỏ hàng!';
                            _dismissDialog() {
                              Navigator.pop(context);
                            }

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Thông báo'),
                                    // content: Text(
                                    //     'Mã sản phẩm: ${product.product_id}\nSố lượng: ${colorDots.quantity}'),
                                    content: Text(noti),
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
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
