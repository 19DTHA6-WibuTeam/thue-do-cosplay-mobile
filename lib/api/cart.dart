import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/All.dart';
// import 'package:shop_app/shared_preferences.dart';

Future<List<Cart>?> getCarts(Future<String> _userId) async {
  String userId = await _userId;
  // print(userId);
  final response =
      await http.get(Uri.parse(API_URL + '?action=get_carts&user_id=$userId'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['success'] == false) return null;
    List<Cart> carts = [];
    for (var item in data['data']) {
      carts.add(Cart.fromJson(item));
    }
    return carts;
  } else {
    throw Exception('Failed to load carts');
  }
}

Future<bool> postCart(
    Future<String> _userId, String productId, int cartProductQuantity) async {
  String userId = await _userId;
  final response = await http.get(Uri.parse(API_URL +
      '?action=post_cart&user_id=$userId&product_id=$productId&cart_product_quantity=$cartProductQuantity'));

  if (response.statusCode == 200)
    return jsonDecode(response.body)['success'];
  else
    return false;
}

Future<bool> deleteCart(Future<String> _userId, String productId) async {
  String userId = await _userId;
  final response = await http.get(Uri.parse(
      API_URL + '?action=delete_cart&user_id=$userId&product_id=$productId'));

  if (response.statusCode == 200)
    return jsonDecode(response.body)['success'];
  else
    return false;
}
