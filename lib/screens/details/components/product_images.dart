import 'package:flutter/material.dart';
import 'package:shop_app/models/All.dart';
// import 'package:shop_app/screens/details/components/custom_app_bar.dart';
// import 'package:shop_app/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          // width: getProportionateScreenWidth(480), // 238
          width: double.infinity,
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product.product_id,
              child: Image.network(
                  widget.product.product_img.split('|')[selectedImage]),
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)), // Không biết tại sao tác giả lại ẩn nhưng thôi cứ bật lên. :D
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.product.product_img.split('|').length,
                (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(widget.product.product_img.split('|')[index]),
      ),
    );
  }
}
