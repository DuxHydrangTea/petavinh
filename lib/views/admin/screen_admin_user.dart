import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/controllers/admin/useradmincontroller.dart';

class ScreenAdminUser extends StatelessWidget {
  const ScreenAdminUser({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserAdminController());
    return GetBuilder<UserAdminController>(builder: (controller) {
      return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    //border: Border.all(),
                    ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const FaIcon(FontAwesomeIcons.bars),
                        const Spacer(),
                        const Image(
                            height: 40,
                            image: AssetImage(
                                "assets/images/Logo-Ultra-Large.png")),
                        const Gap(10),
                        Text(
                          "Dasboard",
                          style: TextStyle(
                            color: MyColor.mainColor,
                            fontSize: 20,
                            fontWeight: MyFontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        const CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              AssetImage("assets/images/avatar1.jpg"),
                        )
                      ],
                    ),
                    const Gap(20),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xffefefef),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Text(
                                "User table",
                                style: TextStyle(
                                  fontWeight: MyFontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text("See all"),
                            ],
                          ),
                          const Gap(10),
                          //// listttttt user ////
                          SizedBox(
                            height: 700,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.listUser.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: index.isEven
                                        ? const Color(0xffefefef)
                                        : Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text((controller.listUser[index].id)
                                          .toString()),
                                      const Gap(10),
                                      CircleAvatar(
                                        backgroundImage: FileImage(File(
                                            controller.listUser[index].avatar)),
                                      ),
                                      const Gap(10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.listUser[index].fullname,
                                            style: const TextStyle(
                                                fontWeight:
                                                    MyFontWeight.semiBold),
                                          ),
                                          Text(
                                              "@${controller.listUser[index].username}"),
                                        ],
                                      ),
                                      const Spacer(),
                                      FaIcon(
                                        FontAwesomeIcons.squareXmark,
                                        color: MyColor.heartColor,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
