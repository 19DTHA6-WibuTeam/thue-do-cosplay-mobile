import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_app/models/All.dart';
// import 'package:shop_app/shared_preferences.dart';

// Future<List<Cart>?> getCarts(Future<String> _userId) async {
//   String userId = await _userId;
//   // print(userId);
//   final response = await http.get(Uri.parse(
//       'https://wibuteam.phatdev.xyz/api/?action=get_carts&user_id=$userId'));

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     if (data['success'] == false) return null;
//     List<Cart> carts = [];
//     for (var item in data['data']) {
//       carts.add(Cart.fromJson(item));
//     }
//     return carts;
//   } else {
//     throw Exception('Failed to load carts');
//   }
// }

Future<bool> postInvoice(Future<String> _userId, String fullname,
    String phoneNumber, String email, String address, String note) async {
  String userId = await _userId;
  var map = new Map<String, dynamic>();
  map['user_id'] = userId;
  map['user_fullname'] = fullname;
  map['user_phone_number'] = phoneNumber;
  map['user_email'] = email;
  map['user_address'] = address;
  map['order_note'] = note;
  final response = await http.post(
    Uri.parse('https://wibuteam.phatdev.xyz/api/?action=post_invoice'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: map,
  );
  if (response.statusCode == 200)
    return jsonDecode(response.body)['success'];
  else
    return false;
}
