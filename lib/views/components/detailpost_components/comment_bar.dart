import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:petavinh/views/components/auth_components/mytextfield.dart';

class CommentBar extends StatelessWidget {
  const CommentBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: const FaIcon(
                  FontAwesomeIcons.x,
                  size: 17,
                ),
              ),
              const Text("Comment"),
              const FaIcon(FontAwesomeIcons.heart),
            ],
          ),
          const Gap(10),
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(
                  "assets/images/avatar1.jpg",
                ),
              ),
              const Gap(10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
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
              const TextButton(
                  onPressed: null,
                  child: Text(
                    "Send",
                    style: TextStyle(color: Color(0xff3f3f3f)),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
