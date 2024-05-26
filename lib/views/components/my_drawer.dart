import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/models/user.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  VoidCallback onPressLogOut;
  User user;
  MyDrawer({super.key, required this.onPressLogOut, required this.user});

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
            child: Center(
              child: Column(
                children: [
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: 70,
                        //backgroundImage: AssetImage(user.avatar),
                        backgroundImage: Image.file(File(user.avatar)).image,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Text(
                    user.fullname,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: MyFontWeight.bold,
                    ),
                  ),
                  Text(
                    "@${user.username}",
                    style: const TextStyle(
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
              'Search',
              style: TextStyle(
                color: MyColor.mainColor,
                fontWeight: MyFontWeight.semiBold,
              ),
            ),
            onTap: null,
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
              Get.toNamed("/group");
            },
          ),
          ListTile(
            title: Text(
              'Profile',
              style: TextStyle(
                color: MyColor.mainColor,
                fontWeight: MyFontWeight.semiBold,
              ),
            ),
            onTap: () {
              Get.toNamed("/profile");
            },
          ),
          ListTile(
            title: Text(
              'Log out',
              style: TextStyle(
                color: MyColor.mainColor,
                fontWeight: MyFontWeight.semiBold,
              ),
            ),
            onTap: onPressLogOut,
          )
        ],
      ),
    );
  }
}
