import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/All.dart';
// import 'package:shop_app/shared_preferences.dart';

Future<List<Invoice>?> getInvoices(
    Future<String> _userId, int page, int limit) async {
  String userId = await _userId;
  // print(userId);
  final response = await http.get(Uri.parse(
      'https://wibuteam.phatdev.xyz/api/?action=get_invoices&user_id=$userId&page=$page&limit=$limit'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['success'] == false) return null;
    List<Invoice> invoices = [];
    for (var item in data['data']) {
      invoices.add(Invoice.fromJson(item));
    }
    return invoices;
  } else
    return null;
}

Future<List<InvoiceDetails>?> getInvoiceDetails(String invoiceId) async {
  final response = await http.get(
      Uri.parse(API_URL + '?action=get_invoice_details&invoice_id=$invoiceId'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['success'] == false) return null;
    List<InvoiceDetails> invoiceDetails = [];
    for (var item in data['data']) {
      invoiceDetails.add(InvoiceDetails.fromJson(item));
    }
    return invoiceDetails;
  } else
    return null;
}

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
    Uri.parse(API_URL + '?action=post_invoice'),
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
