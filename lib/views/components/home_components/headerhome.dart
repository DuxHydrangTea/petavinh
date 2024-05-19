// ignore: unnecessary_import
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/views/components/home_components/menu_bar.dart';

// ignore: must_be_immutable
class HeaderHome extends StatelessWidget {
  String helloUsername;
  VoidCallback logout;
  HeaderHome({super.key, required this.helloUsername, required this.logout});

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
                backgroundImage: AssetImage('assets/images/avatar1.jpg'),
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
                    style: const TextStyle(fontWeight: MyFontWeight.bold),
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(FontAwesomeIcons.bell),
                  const Gap(10),
                  const Gap(10),
                  InkWell(
                      onTap: logout,
                      child: const Icon(FontAwesomeIcons.arrowRightFromBracket))
                ],
              )
            ],
          ),
          const Gap(10),
          const MyMenuBar(),
          const Gap(10),
          const ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xffeeedf2)),
                padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 10),
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar1.jpg'),
                    radius: 15,
                  ),
                  Gap(5),
                  Text(
                    "What do your pet today?",
                    style: TextStyle(fontWeight: MyFontWeight.medium),
                  ),
                  Spacer(),
                  Icon(
                    FontAwesomeIcons.image,
                    color: Color(0xff524e4e),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
