import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_app/models/All.dart';
import 'package:shop_app/shared_preferences.dart';

Future<User?> fetchLogin(String email, String password) async {
  var map = new Map<String, dynamic>();
  map['email'] = email;
  map['password'] = password;
  final response = await http.post(
    Uri.parse('https://wibuteam.phatdev.xyz/api/?action=login'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: map,
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final data = jsonDecode(response.body);
    // print(data);
    if (data['success'] == false) return null;
    return User.fromJson(data['data']);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load info');
  }
}

Future<bool> saveLogin(User user) async {
  await BaseSharedPreferences.setString('user_id', user.user_id);
  await BaseSharedPreferences.setString('user_fullname', user.user_fullname);
  await BaseSharedPreferences.setString('user_email', user.user_email);
  await BaseSharedPreferences.setString('user_token', user.user_token ?? '');
  return true;
}
