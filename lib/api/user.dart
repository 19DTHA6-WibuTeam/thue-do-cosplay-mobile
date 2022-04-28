import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/All.dart';

Future<User?> getUser(Future<String> _userId) async {
  String userId = await _userId;
  final response =
      await http.get(Uri.parse(API_URL + '?action=get_user&user_id=$userId'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['success'] == false) return null;
    return User.fromJson(data['data']);
  } else
    return null;
}

Future<bool> updateUser(
    Future<String> _userId,
    String userFullname,
    String userEmail,
    String userPhoneNumber,
    String userAddress,
    String userBankAccountNumber,
    String userBankName) async {
  String userId = await _userId;
  var map = new Map<String, dynamic>();
  map['user_id'] = userId;
  map['user_fullname'] = userFullname;
  map['user_email'] = userEmail;
  map['user_phone_number'] = userPhoneNumber;
  map['user_address'] = userAddress;
  map['user_bank_account_number'] = userBankAccountNumber;
  map['user_bank_name'] = userBankName;
  final response = await http.post(
    Uri.parse(API_URL + '?action=update_user'),
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
