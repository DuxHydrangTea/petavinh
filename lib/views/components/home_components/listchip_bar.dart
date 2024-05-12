import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/controllers/homecontroller.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ListChipBar extends StatelessWidget {
  final topicController = Get.put(HomeController());
  List<Widget> children = [];
  String label;
  ListChipBar({super.key, required this.children, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: MyFontWeight.bold),
                ),
                Text(
                  "See All",
                  style: TextStyle(
                      color: MyColor.textHomeColor,
                      fontWeight: MyFontWeight.bold),
                ),
              ],
            ),
            const Gap(5),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...children,
                ],
              ),
            ),
          ],
        ));
  }
}
