// ignore_for_file: non_constant_identifier_names

class Res {
  final String success;

  Res(this.success);
  Res.fromJson(Map<String, dynamic> json) : success = json['success'];
  Map<String, dynamic> toJson() => {
        'success': success,
      };
}

class User {
  final String user_id;
  final String user_fullname;
  final String user_email;
  final String? user_phone_number;
  final String? user_address;
  final String? user_bank_account_number;
  final String? user_bank_name;
  final String? user_token;

  User(
      this.user_id,
      this.user_fullname,
      this.user_email,
      this.user_phone_number,
      this.user_address,
      this.user_bank_account_number,
      this.user_bank_name,
      this.user_token);
  User.fromJson(Map<String, dynamic> json)
      : user_id = json['user_id'],
        user_fullname = json['user_fullname'],
        user_email = json['user_email'],
        user_phone_number = json['user_phone_number'],
        user_address = json['user_address'],
        user_bank_account_number = json['user_bank_account_number'],
        user_bank_name = json['user_bank_name'],
        user_token = json['user_token'];
  Map<String, dynamic> toJson() => {
        'user_id': user_id,
        'user_fullname': user_fullname,
        'user_email': user_email,
        'user_phone_number': user_phone_number,
        'user_address': user_address,
        'user_bank_account_number': user_bank_account_number,
        'user_bank_name': user_bank_name,
        'user_token': user_token,
      };
}

class ProductType {
  final String product_type_id;
  final String product_type_name;

  ProductType(this.product_type_id, this.product_type_name);
  ProductType.fromJson(Map<String, dynamic> json)
      : product_type_id = json['product_type_id'],
        product_type_name = json['product_type_name'];
  Map<String, dynamic> toJson() => {
        'product_type_id': product_type_id,
        'product_type_name': product_type_name,
      };
}

class Product {
  final String product_id;
  final String product_name;
  final String? product_type_id;
  final String? product_type_name;
  final int? product_price;
  final int product_rental_price;
  final String product_img;
  final int? product_quantity;
  final String? product_sizes;
  final int? product_weight;
  final String? product_description;

  Product(
      this.product_id,
      this.product_name,
      this.product_type_id,
      this.product_type_name,
      this.product_price,
      this.product_rental_price,
      this.product_img,
      this.product_quantity,
      this.product_sizes,
      this.product_weight,
      this.product_description);
  Product.fromJson(Map<String, dynamic> json)
      : product_id = json['product_id'],
        product_name = json['product_name'],
        product_type_id = json['product_type_id'],
        product_type_name = json['product_type_name'],
        product_price = int.parse(json['product_price']),
        product_rental_price = int.parse(json['product_rental_price']),
        product_img = json['product_img'],
        product_quantity = int.parse(json['product_quantity']),
        product_sizes = json['product_sizes'],
        product_weight = int.parse(json['product_weight']),
        product_description = json['product_description'];
  Map<String, dynamic> toJson() => {
        'product_id': product_id,
        'product_name': product_name,
        'product_type_id': product_type_id,
        'product_type_name': product_type_name,
        'product_price': product_price,
        'product_rental_price': product_rental_price,
        'product_img': product_img,
        'product_quantity': product_quantity,
        'product_sizes': product_sizes,
        'product_weight': product_weight,
        'product_description': product_description,
      };
}

class Cart {
  final String product_id;
  final String product_name;
  final int product_rental_price;
  final String product_img;
  final int product_quantity;
  final int product_weight;
  final int cart_product_quantity;

  Cart(
      this.product_id,
      this.product_name,
      this.product_rental_price,
      this.product_img,
      this.product_quantity,
      this.product_weight,
      this.cart_product_quantity);
  Cart.fromJson(Map<String, dynamic> json)
      : product_id = json['product_id'],
        product_name = json['product_name'],
        product_rental_price = int.parse(json['product_rental_price']),
        product_img = json['product_img'],
        product_quantity = int.parse(json['product_quantity']),
        product_weight = int.parse(json['product_weight']),
        cart_product_quantity = int.parse(json['cart_product_quantity']);
  Map<String, dynamic> toJson() => {
        'product_id': product_id,
        'product_name': product_name,
        'product_rental_price': product_rental_price,
        'product_img': product_img,
        'product_quantity': product_quantity,
        'product_weight': product_weight,
        'cart_product_quantity': cart_product_quantity,
      };
}

class Invoice {}
