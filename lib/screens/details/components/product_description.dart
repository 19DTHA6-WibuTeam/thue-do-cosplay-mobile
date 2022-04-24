import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/models/All.dart';
// import 'package:shop_app/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            product.product_name,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(15)),
            width: getProportionateScreenWidth(64),
            // decoration: BoxDecoration(
            //   color:
            //       // product.isFavourite ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
            //       true ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
            //   borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(20),
            //     bottomLeft: Radius.circular(20),
            //   ),
            // ),
            // child: SvgPicture.asset(
            //   "assets/icons/Heart Icon_2.svg",
            //   color:
            //       // product.isFavourite ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
            //       true ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
            //   height: getProportionateScreenWidth(16),
            // ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            product.product_description ?? '',
            maxLines: 3,
            style: TextStyle(
              // color: Color(0xFFDBDEE4),
              fontSize: 12,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "Giá thuê: ${numberWithDot(product.product_rental_price.toString())}đ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                    // fontSize: 12,
                  ),
                ),
                SizedBox(width: 5),
                // Icon(
                //   Icons.arrow_forward_ios,
                //   size: 12,
                //   color: kPrimaryColor,
                // ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            "Đã bán 0 | Còn ${product.product_quantity} sản phẩm",
            maxLines: 3,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            "Loại sản phẩm: ${product.product_type_name}",
            maxLines: 3,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
