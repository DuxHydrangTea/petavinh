import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myfontweight.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              color: MyColor.mainColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: const Center(
              child: Column(
                children: [
                  Gap(10),
                  Gap(10),
                  Text(
                    "user.fullname",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: MyFontWeight.bold,
                    ),
                  ),
                  Text(
                    "@zzzz",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: MyFontWeight.medium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              'User',
              style: TextStyle(
                color: MyColor.mainColor,
                fontWeight: MyFontWeight.semiBold,
              ),
            ),
            onTap: () {
              Get.offAllNamed("/admin/user/");
            },
          ),
          ListTile(
            title: Text(
              'Post',
              style: TextStyle(
                color: MyColor.mainColor,
                fontWeight: MyFontWeight.semiBold,
              ),
            ),
            onTap: () {
              Get.offAllNamed("/admin/post/");
            },
          ),
          ListTile(
            title: Text(
              'Topic',
              style: TextStyle(
                color: MyColor.mainColor,
                fontWeight: MyFontWeight.semiBold,
              ),
            ),
            onTap: () {
              Get.offAllNamed("/admin/topic/");
            },
          ),
          ListTile(
            title: Text(
              'Group',
              style: TextStyle(
                color: MyColor.mainColor,
                fontWeight: MyFontWeight.semiBold,
              ),
            ),
            onTap: () {
              Get.offAllNamed("/admin/group/");
            },
          )
        ],
      ),
    );
  }
}
