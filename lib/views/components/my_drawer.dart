import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myfontweight.dart';

class MyDrawer extends StatelessWidget {
  VoidCallback onPressLogOut;
  MyDrawer({super.key, required this.onPressLogOut});

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
                      child: const CircleAvatar(
                        radius: 70,
                        backgroundImage:
                            AssetImage("assets/images/avatar1.jpg"),
                      ),
                    ),
                  ),
                  const Gap(10),
                  const Text(
                    "Nguyen Ngoc Dung",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: MyFontWeight.bold,
                    ),
                  ),
                  const Text(
                    "@ngocdung",
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
              'Tìm kiếm',
              style: TextStyle(
                color: MyColor.mainColor,
                fontWeight: MyFontWeight.semiBold,
              ),
            ),
            onTap: null,
          ),
          ListTile(
            title: Text(
              'Nhóm',
              style: TextStyle(
                color: MyColor.mainColor,
                fontWeight: MyFontWeight.semiBold,
              ),
            ),
            onTap: null,
          ),
          ListTile(
            title: Text(
              'Trang cá nhân',
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
              'Đăng xuất',
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
