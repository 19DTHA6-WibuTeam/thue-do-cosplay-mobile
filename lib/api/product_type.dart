import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_app/models/All.dart';
// import 'package:shop_app/shared_preferences.dart';

Future<List<ProductType>?> getProductTypes() async {
  final response = await http.get(
      Uri.parse('https://wibuteam.phatdev.xyz/api/?action=get_product_types'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['success'] == false) return null;
    List<ProductType> productTypes = [];
    for (var item in data['data']) {
      productTypes.add(ProductType.fromJson(item));
    }
    return productTypes;
  } else {
    throw Exception('Failed to load product types');
  }
}
