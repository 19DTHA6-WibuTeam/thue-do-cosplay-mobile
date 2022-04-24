import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_app/models/All.dart';
import 'package:shop_app/shared_preferences.dart';

Future<User?> getUser(Future<String> _userId) async {
  String userId = await _userId;
  final response = await http.get(Uri.parse(
      'https://wibuteam.phatdev.xyz/api/?action=get_user&user_id=$userId'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['success'] == false) return null;
    return User.fromJson(data['data']);
  } else
    return null;
}
