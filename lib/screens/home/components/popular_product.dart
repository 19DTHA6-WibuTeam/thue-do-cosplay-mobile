import 'package:flutter/material.dart';
import 'package:shop_app/api/product.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/All.dart';
import 'package:shop_app/screens/product/product_screen.dart';
// import 'package:shop_app/models/Product.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List<Product> products = [];
    // getProducts(1, 10).then((List<Product> products) {
    //   // products.addAll(product);
    // });

    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Sản phẩm mới",
            press: () {
              Navigator.pushNamed(context, ProductScreen.routeName,
                  arguments: ProductArguments(keyword: ''));
            },
            seeMore: true,
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: FutureBuilder<List<Product>?>(
            future: getProducts(1, 10), // async work
            builder:
                (BuildContext context, AsyncSnapshot<List<Product>?> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('Loading...');
                default:
                  if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Text('Wut.');
                  } else {
                    List<Product>? products = snapshot.data;
                    // return Text('Result: ${snapshot.data}');
                    return Row(
                      children: [
                        ...List.generate(
                          products!.length,
                          (index) {
                            // if (demoProducts[index].isPopular)
                            //   return ProductCard(product: demoProducts[index]);
                            return ProductCard(product: products[index]);
                            return SizedBox
                                .shrink(); // here by default width and height is 0
                          },
                        ),
                        SizedBox(width: getProportionateScreenWidth(20)),
                      ],
                    );
                  }
              }
            },
          ),

          // child: Row(
          //   children: [
          //     ...List.generate(
          //       products.length,
          //       (index) {
          //         // if (demoProducts[index].isPopular)
          //         //   return ProductCard(product: demoProducts[index]);
          //         return ProductCard(product: products[index]);
          //         return SizedBox
          //             .shrink(); // here by default width and height is 0
          //       },
          //     ),
          //     SizedBox(width: getProportionateScreenWidth(20)),
          //   ],
          // ),
        )
      ],
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Posts"),
    //   ),
    //   body: FutureBuilder(
    //     future: getProducts(),
    //     builder:
    //         (BuildContext context, AsyncSnapshot<List<Product>?> snapshot) {
    //       if (snapshot.hasData) {
    //         List<Product>? products = snapshot.data;
    //         return Column(
    //           children: [
    //             Padding(
    //               padding: EdgeInsets.symmetric(
    //                   horizontal: getProportionateScreenWidth(20)),
    //               child: SectionTitle(title: "Popular Products", press: () {}),
    //             ),
    //             SizedBox(height: getProportionateScreenWidth(20)),
    //             SingleChildScrollView(
    //               scrollDirection: Axis.horizontal,
    //               child: Row(
    //                 children: [
    //                   ...List.generate(
    //                     products!.length,
    //                     (index) {
    //                       return ProductCard(product: products[index]);
    //                       // return SizedBox
    //                       //     .shrink(); // here by default width and height is 0
    //                     },
    //                   ),
    //                   SizedBox(width: getProportionateScreenWidth(20)),
    //                 ],
    //               ),
    //             )
    //           ],
    //         );
    //       } else {
    //         return Center(child: CircularProgressIndicator());
    //       }
    //     },
    //   ),
    // );
  }
}
