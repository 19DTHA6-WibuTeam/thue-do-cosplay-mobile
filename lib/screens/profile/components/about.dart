import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/enums.dart';

import 'profile_menu.dart';

class AboutScreen extends StatelessWidget {
  static String routeName = "/about";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: kPrimaryColor,
                  padding: EdgeInsets.all(20),
                ),
                onPressed: () => {},
                child: Text(
                  'GIỚI THIỆU VỀ ỨNG DỤNG',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Hiện nay, có nhiều vấn đề mà khách hàng thuê đồ cosplay sẽ gặp phải khi đi thuê đồ như cửa hàng không có sẵn những mặt hàng mà khách hàng cần, hoặc khách hàng không thuận tiện đến cửa hàng để thuê đồ. Do đó chúng tôi đã áp dụng được công nghệ, website và app mobile “Cho thuê đồ Cosplay” được thực hiện nhằm giúp khách hàng dễ dàng hơn trong việc thuê đồ. Khách hàng truy cập vào website hoặc app trên mobile, tại đây khách hàng có thể tìm những sản phẩm cần thuê phù hợp với bản thân.\n\nWebsite: wibuteam.phatdev.xyz\nSĐT: 0777 100 xxx',
                textAlign: TextAlign.justify,
                style: TextStyle(height: 1.8),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
