import 'package:flutter/material.dart';
import 'package:shop_app/api/product_type.dart';
import 'package:shop_app/models/All.dart';
import 'package:shop_app/screens/category/category_screen.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Danh mục",
            press: () {
              Navigator.pushNamed(context, CategoryScreen.routeName);
            },
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          // child: Row(
          //   children: [
          //     SpecialOfferCard(
          //       image: "assets/images/Image Banner 2.png",
          //       category: "Smartphone",
          //       numOfBrands: 18,
          //       press: () {},
          //     ),
          //     SpecialOfferCard(
          //       image: "assets/images/Image Banner 3.png",
          //       category: "Fashion",
          //       numOfBrands: 24,
          //       press: () {},
          //     ),
          //     SizedBox(width: getProportionateScreenWidth(20)),
          //   ],
          // ),
          child: FutureBuilder<List<ProductType>?>(
            future: getProductTypes(), // async work
            builder: (BuildContext context,
                AsyncSnapshot<List<ProductType>?> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('Loading...');
                default:
                  if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Text('Wut.');
                  } else {
                    List<ProductType>? productTypes = snapshot.data;
                    // return Text('Result: ${snapshot.data}');
                    return Row(
                      children: [
                        ...List.generate(
                          productTypes!.length,
                          (index) {
                            // print(productTypes[index].product_type_id.runtimeType);
                            return SpecialOfferCard(
                              image:
                                  "assets/images/product_types/${index + 1}.jpg",
                              category: productTypes[index].product_type_name,
                              numOfBrands:
                                  productTypes[index].product_type_quantity,
                              press: () {},
                            );
                          },
                        ),
                        SizedBox(width: getProportionateScreenWidth(20)),
                      ],
                    );
                  }
              }
            },
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(242),
          height: getProportionateScreenWidth(100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.5),
                        Color(0xFF343434).withOpacity(0.5),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "$numOfBrands sản phẩm")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
