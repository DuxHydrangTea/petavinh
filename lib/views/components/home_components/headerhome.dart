import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:petavinh/config/myfontweight.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});

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
      child: const Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar1.jpg'),
              ),
              Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good morning!",
                    style: TextStyle(fontWeight: MyFontWeight.bold),
                  ),
                  Text(
                    "Nguyen Ngoc Dung",
                    style: TextStyle(fontWeight: MyFontWeight.bold),
                  )
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Icon(FontAwesomeIcons.bell),
                  Gap(10),
                  Icon(FontAwesomeIcons.heart)
                ],
              )
            ],
          ),
          Gap(10),
          ElevatedButton(
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
