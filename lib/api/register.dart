import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';

Future<bool?> fetchRegister(
    String fullname, String email, String password) async {
  var map = new Map<String, dynamic>();
  map['fullname'] = fullname;
  map['email'] = email;
  map['password'] = password;
  final response = await http.post(
    Uri.parse(API_URL + '?action=register'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: map,
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['success'];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return null;
    // throw Exception('Failed to load info');
  }
}
