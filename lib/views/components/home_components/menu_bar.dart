import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:petavinh/config/mycolor.dart';

class MyMenuBar extends StatelessWidget {
  const MyMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
              child: IconButton(
            onPressed: () {
              Get.offAllNamed("/");
            },
            icon: FaIcon(
              FontAwesomeIcons.house,
              size: 20,
              color: MyColor.mainColor,
            ),
          )),
          Expanded(
              child: IconButton(
            onPressed: null,
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: 20,
              color: MyColor.mainColor,
            ),
          )),
          Expanded(
              child: IconButton(
            onPressed: null,
            icon: FaIcon(
              FontAwesomeIcons.userGroup,
              size: 20,
              color: MyColor.mainColor,
            ),
          )),
          Expanded(
              child: IconButton(
            onPressed: () {
              Get.toNamed("/profile");
            },
            icon: FaIcon(
              FontAwesomeIcons.solidUser,
              size: 20,
              color: MyColor.mainColor,
            ),
          )),
        ],
      ),
    );
  }
}
