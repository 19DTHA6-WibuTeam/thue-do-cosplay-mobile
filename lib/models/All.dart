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
  final int product_type_quantity;

  ProductType(
      this.product_type_id, this.product_type_name, this.product_type_quantity);
  ProductType.fromJson(Map<String, dynamic> json)
      : product_type_id = json['product_type_id'],
        product_type_name = json['product_type_name'],
        product_type_quantity = int.parse(json['product_type_quantity']);
  Map<String, dynamic> toJson() => {
        'product_type_id': product_type_id,
        'product_type_name': product_type_name,
        'product_type_quantity': product_type_quantity,
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

class Invoice {
  final String invoice_id;
  final String invoice_user_fullname;
  final String invoice_user_phone_number;
  final String invoice_user_email;
  final int invoice_subtotal;
  final int invoice_fee_transport;
  final int invoice_fee_bond;
  final int invoice_status_id;
  final String invoice_status_name;
  final int invoice_num_rental_days;
  final String invoice_created_at;
  Invoice(
      this.invoice_id,
      this.invoice_user_fullname,
      this.invoice_user_phone_number,
      this.invoice_user_email,
      this.invoice_subtotal,
      this.invoice_fee_transport,
      this.invoice_fee_bond,
      this.invoice_status_id,
      this.invoice_status_name,
      this.invoice_num_rental_days,
      this.invoice_created_at);
  Invoice.fromJson(Map<String, dynamic> json)
      : invoice_id = json['invoice_id'],
        invoice_user_fullname = json['invoice_user_fullname'],
        invoice_user_phone_number = json['invoice_user_phone_number'],
        invoice_user_email = json['invoice_user_email'],
        invoice_subtotal = int.parse(json['invoice_subtotal']),
        invoice_fee_transport = int.parse(json['invoice_fee_transport']),
        invoice_fee_bond = int.parse(json['invoice_fee_bond']),
        invoice_status_id = int.parse(json['invoice_status_id']),
        invoice_status_name = json['invoice_status_name'],
        invoice_num_rental_days = int.parse(json['invoice_num_rental_days']),
        invoice_created_at = json['invoice_created_at'];
  Map<String, dynamic> toJson() => {
        'invoice_id': invoice_id,
        'invoice_user_fullname': invoice_user_fullname,
        'invoice_user_phone_number': invoice_user_phone_number,
        'invoice_user_email': invoice_user_email,
        'invoice_subtotal': invoice_subtotal,
        'invoice_fee_transport': invoice_fee_transport,
        'invoice_fee_bond': invoice_fee_bond,
        'invoice_status_id': invoice_status_id,
        'invoice_status_name': invoice_status_name,
        'invoice_num_rental_days': invoice_num_rental_days,
        'invoice_created_at': invoice_created_at,
      };
}

class InvoiceDetails {
  final String product_id;
  final String product_name;
  final String product_img;
  final int invd_product_quantity;
  final int invd_product_rental_price;
  InvoiceDetails.fromJson(Map<String, dynamic> json)
      : product_id = json['product_id'],
        product_name = json['product_name'],
        product_img = json['product_img'],
        invd_product_quantity = int.parse(json['invd_product_quantity']),
        invd_product_rental_price =
            int.parse(json['invd_product_rental_price']);
  Map<String, dynamic> toJson() => {
        'product_id': product_id,
        'product_name': product_name,
        'product_img': product_img,
        'invd_product_quantity': invd_product_quantity,
        'invd_product_rental_price': invd_product_rental_price,
      };
}
