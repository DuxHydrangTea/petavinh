// ignore: unnecessary_import
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/views/components/container_border.dart';

// ignore: must_be_immutable
class HeaderHome extends StatelessWidget {
  String helloUsername;
  String avatar;
  VoidCallback logout;
  VoidCallback onDrawer;
  VoidCallback showSheet;
  HeaderHome(
      {super.key,
      required this.helloUsername,
      required this.logout,
      required this.onDrawer,
      required this.avatar,
      required this.showSheet});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xffeeedf2),
          offset: Offset(0, 4),
          blurRadius: 4,
        ),
      ], color: Colors.white),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage:
                    AssetImage('assets/images/Logo-Ultra-Large.png'),
              ),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Good morning!",
                    style: TextStyle(fontWeight: MyFontWeight.bold),
                  ),
                  Text(
                    helloUsername,
                    style: TextStyle(
                      fontWeight: MyFontWeight.bold,
                      fontSize: 20,
                      color: MyColor.bookMarkColor,
                    ),
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  GestureDetector(
                      onTap: onDrawer,
                      child: const Icon(FontAwesomeIcons.bars)),
                ],
              )
            ],
          ),
          const Gap(10),
          ElevatedButton(
              onPressed: null,
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xffeeedf2)),
                padding: MaterialStatePropertyAll(
                  //EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  EdgeInsets.only(
                    left: 10,
                    right: 19,
                    bottom: 8,
                    top: 8,
                  ),
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
              child: GestureDetector(
                onTap: showSheet,
                child: Row(
                  children: [
                    ContainerBorder(
                      child: CircleAvatar(
                        backgroundImage: AssetImage(avatar),
                        radius: 15,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      "$helloUsername What do your pet today?",
                      style: const TextStyle(fontWeight: MyFontWeight.medium),
                    ),
                    const Spacer(),
                    Icon(
                      FontAwesomeIcons.image,
                      color: MyColor.mainColor,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
