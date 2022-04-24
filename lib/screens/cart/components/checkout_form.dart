import 'package:flutter/material.dart';
import 'package:shop_app/api/register.dart';
import 'package:shop_app/api/user.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/helper/keyboard.dart';
import 'package:shop_app/models/All.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/shared_preferences.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutForm extends StatefulWidget {
  String? fullname;
  String? email;
  String? phoneNumber;
  String? address;
  String? note;

  TextEditingController fullnameText = TextEditingController();
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController phoneNumberText = TextEditingController();
  TextEditingController addressText = TextEditingController();
  TextEditingController noteText = TextEditingController();

  @override
  _CheckoutFormState createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  User? user;

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: getUser(BaseSharedPreferences.getString('user_id')),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
                return Text('Wut.');
              } else {
                user = snapshot.data;
                // print(user?.user_phone_number);
                return SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: SizeConfig.screenHeight * 0.04),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Text(
                                    "Xem lại thông tin người đặt hàng",
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                      height: getProportionateScreenHeight(30)),
                                  buildFullnameFormField(user?.user_fullname),
                                  SizedBox(
                                      height: getProportionateScreenHeight(30)),
                                  buildEmailFormField(user?.user_email),
                                  SizedBox(
                                      height: getProportionateScreenHeight(30)),
                                  buildPhoneNumberFormField(
                                      user?.user_phone_number),
                                  SizedBox(
                                      height: getProportionateScreenHeight(30)),
                                  buildAddressFormField(user?.user_address),
                                  SizedBox(
                                      height: getProportionateScreenHeight(30)),
                                  buildNoteFormField(),
                                  FormError(errors: errors),
                                  SizedBox(
                                      height: getProportionateScreenHeight(40)),
                                ],
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.08),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
          }
        });

    // return Form(
    //   key: _formKey,
    //   child: Column(
    //     children: [
    //       SizedBox(height: getProportionateScreenHeight(30)),
    //       buildFullnameFormField(),
    //       SizedBox(height: getProportionateScreenHeight(30)),
    //       buildEmailFormField(),
    //       SizedBox(height: getProportionateScreenHeight(30)),
    //       buildPasswordFormField(),
    //       SizedBox(height: getProportionateScreenHeight(30)),
    //       buildConformPassFormField(),
    //       FormError(errors: errors),
    //       SizedBox(height: getProportionateScreenHeight(40)),
    //       // DefaultButton(
    //       //   text: "Tiếp tục",
    //       //   press: () async {
    //       //     if (_formKey.currentState!.validate()) {
    //       //       _formKey.currentState!.save();

    //       //       KeyboardUtil.hideKeyboard(context);
    //       //       // if all are valid then go to success screen
    //       //       // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
    //       //     }
    //       //   },
    //       // ),
    //     ],
    //   ),
    // );
  }

  TextFormField buildNoteFormField() {
    return TextFormField(
      controller: widget.noteText,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => widget.note = newValue,
      decoration: InputDecoration(
        labelText: "Ghi chú đơn hàng",
        hintText: "Nhập ghi chú cho đơn hàng (nếu có)",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildAddressFormField(String? text) {
    widget.addressText.text = text ?? '';
    return TextFormField(
      controller: widget.addressText,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => widget.address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Địa chỉ giao hàng",
        hintText: "Nhập địa chỉ giao hàng",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon:
        //     CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField(String? text) {
    widget.phoneNumberText.text = text ?? '';
    return TextFormField(
      controller: widget.phoneNumberText,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => widget.phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Số điện thoại",
        hintText: "Nhập số điện thoại",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField(String? text) {
    widget.emailText.text = text ?? '';
    return TextFormField(
      controller: widget.emailText,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => widget.email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Nhập địa chỉ email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildFullnameFormField(String? text) {
    widget.fullnameText.text = text ?? '';
    return TextFormField(
      controller: widget.fullnameText,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => widget.fullname = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Họ tên",
        hintText: "Nhập họ tên của bạn",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
