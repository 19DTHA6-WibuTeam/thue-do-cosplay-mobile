import 'package:flutter/material.dart';

import '../../../size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
    required this.seeMore,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;
  final bool seeMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.black,
          ),
        ),
        seeMore == true
            ? GestureDetector(
                onTap: press,
                child: Text(
                  "Xem thêm",
                  style: TextStyle(color: Color(0xFFBBBBBB)),
                ),
              )
            : Text(''),
      ],
    );
  }
}
