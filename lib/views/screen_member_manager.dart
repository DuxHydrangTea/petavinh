import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/controllers/membermanagercontroller.dart';
import 'package:petavinh/models/user.dart';

class ScreenMemberManager extends StatelessWidget {
  int groupId;
  ScreenMemberManager({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    Get.put(MemberController(groupId: groupId));
    return GetBuilder<MemberController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Member Manager"),
        ),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(2, 2),
                ),
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(-2, -2),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            child: ListView.builder(
                itemCount: controller.listMember.length,
                itemBuilder: (context, index) {
                  User us =
                      controller.getUser(controller.listMember[index].userId);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          index.isEven ? const Color(0xffefefef) : Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(us.id.toString()),
                        const Gap(10),
                        CircleAvatar(
                          backgroundImage: FileImage(File(us.avatar)),
                        ),
                        const Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  us.fullname,
                                  style: TextStyle(
                                    fontWeight: MyFontWeight.semiBold,
                                    color: controller.getAdminGroup(us.id)
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Text("@${us.username}"),
                          ],
                        ),
                        const Spacer(),
                        controller.isAdminGroup() &&
                                !controller.getAdminGroup(us.id)
                            ? GestureDetector(
                                onTap: () {
                                  controller.denyUser(us.id);
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.squareXmark,
                                  color: MyColor.heartColor,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  );
                }),
          ),
        ),
      );
    });
  }
}
