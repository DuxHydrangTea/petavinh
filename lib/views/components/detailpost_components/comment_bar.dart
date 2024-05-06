import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: unused_import
import 'package:petavinh/views/components/auth_components/mytextfield.dart';
import 'package:gap/gap.dart';

class CommentBar extends StatelessWidget {
  const CommentBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/avatar1.jpg"),
          ),
          const Gap(10),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xffB2B2B2))),
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: "Comments...",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Color(0xffB2B2B2))),
              ),
            ),
          ),
          const Gap(10),
          const FaIcon(
            FontAwesomeIcons.paperPlane,
            color: Color(0xff252525),
          )
        ],
      ),
    );
  }
}
