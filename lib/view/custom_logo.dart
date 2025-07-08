import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopapp_v1/utils/color_resource.dart';
import 'package:shopapp_v1/utils/images.dart';

Widget customLogo() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(Images.iconShop, width: 60, height: 60),
      SizedBox(width: 5),
      Text.rich(
          textAlign: TextAlign.center,
          TextSpan(children: [
            TextSpan(
              text: "Grocery ",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: "Borel",
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: "Store",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorResources.getTextColor1(),
                  fontFamily: "Borel"),
            ),
          ]))
    ],
  );
}
