import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyHeroAlbum extends StatelessWidget {
  String tag;
  MyHeroAlbum({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const FaIcon(FontAwesomeIcons.circleXmark)),
                Image.asset(tag)
              ]),
        ),
      ),
    );
  }
}
