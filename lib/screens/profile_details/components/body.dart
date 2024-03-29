import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';

import 'profile_details_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Cập nhật thông tin", style: headingStyle),
                // Text(
                //   "Complete your details or continue \nwith social media",
                //   textAlign: TextAlign.center,
                // ),
                // SizedBox(height: SizeConfig.screenHeight * 0.08),
                ProfileDetailsForm(),
                SizedBox(height: getProportionateScreenHeight(20)),
                // Text(
                //   'By continuing your confirm that you agree \nwith our Term and Condition',
                //   textAlign: TextAlign.center,
                //   style: Theme.of(context).textTheme.caption,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
