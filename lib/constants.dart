import 'package:flutter/material.dart';
import 'package:shop_app/models/All.dart';
import 'package:shop_app/size_config.dart';
import 'package:intl/intl.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Vui lòng nhập email";
const String kInvalidEmailError = "Email không hợp lệ";
const String kPassNullError = "Vui lòng nhập mật khẩu";
const String kShortPassError = "Mật khẩu quá ngắn";
const String kMatchPassError = "Mật khẩu không trùng khớp";
const String kNamelNullError = "Vui lòng nhập tên của bạn";
const String kPhoneNumberNullError = "Vui lòng nhập số điện thoại";
const String kAddressNullError = "Vui lòng nhập địa chỉ";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

const String API_URL = 'https://wibuteam.phatdev.xyz/api/';

class Fee {
  // Phí vận chuyển
  static int transport(int weight) {
    // Gram
    int cost = 0;
    if (weight <= 1000)
      cost = 15000;
    else if (1000 < weight && weight <= 2000)
      cost = 22000;
    else
      cost = weight * 10; // 1.000đ mỗi 0.1kg = 100 gram
    return cost;
  }

  // Phí thế chân (phí đảm bảo tài sản)
  static int bond(int price) {
    int cost = 0;
    if (price <= 1000000)
      cost = 500000;
    else
      cost = (1000000 + price * 35 / 100).toInt();
    return cost;
  }
}

String numberWithDot(String x) {
  return x.toString().replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.');
}

String unixToDate(int unix) {
  var dt = DateTime.fromMillisecondsSinceEpoch(unix);
  var d24 = DateFormat('dd/MM/yyyy, HH:mm').format(dt); // 31/12/2000, 22:00
  return d24;
}

class Calculate with ChangeNotifier {
  Calculate({required this.carts});

  List<Cart> carts;
  int _sum = 0;
  int _num = 0;
  int _weight = 0;

  int get sum => _sum;
  int get num => _num;
  int get weight => _weight;

  void update() async {
    _sum = 0;
    _num = carts.length;
    for (var cart in carts) {
      _sum += cart.cart_product_quantity * cart.product_rental_price;
      _weight += cart.cart_product_quantity * cart.product_weight;
    }
    notifyListeners();
  }
}
