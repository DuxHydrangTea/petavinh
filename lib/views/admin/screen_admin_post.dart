import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/controllers/admin/postadmincontroller.dart';
import 'package:petavinh/views/admin/components/admin_drawer.dart';

class ScreenAdminPost extends StatelessWidget {
  const ScreenAdminPost({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PostAdminController());
    return GetBuilder<PostAdminController>(builder: (controller) {
      return Scaffold(
        key: controller.scaffoldKey,
        endDrawer: const Drawer(
          child: AdminDrawer(),
        ),
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
                        GestureDetector(
                            onTap: () {
                              controller.openDrawer();
                            },
                            child: const FaIcon(FontAwesomeIcons.bars)),
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
                                "Post table",
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
                              itemCount: controller.listAllPost.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => showModalBottomSheet(
                                    isScrollControlled: true,
                                    useSafeArea: true,
                                    context: context,
                                    builder: (context) {
                                      return Scaffold(
                                        appBar: AppBar(),
                                        body: SingleChildScrollView(
                                          child: Container(
                                            padding: const EdgeInsets.all(20),
                                            alignment: Alignment.center,
                                            child: Column(
                                              children: [
                                                controller.listAllPost[index]
                                                            .groupId !=
                                                        0
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                            child: Image.file(
                                                              width: 50,
                                                              File(
                                                                controller.getImageGroup(
                                                                    controller
                                                                        .listAllPost[
                                                                            index]
                                                                        .groupId),
                                                              ),
                                                            ),
                                                          ),
                                                          const Gap(10),
                                                          Text(
                                                              style: TextStyle(
                                                                  color: MyColor
                                                                      .mainColor,
                                                                  fontWeight:
                                                                      MyFontWeight
                                                                          .medium),
                                                              "Group: ${controller.getNameGroup(controller.listAllPost[index].groupId)}")
                                                        ],
                                                      )
                                                    : Container(),
                                                const Gap(20),
                                                Text(
                                                  controller
                                                      .listAllPost[index].title,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          MyFontWeight.medium),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.purple,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  child: Text(
                                                    controller.getTopicNameByID(
                                                        controller
                                                            .listAllPost[index]
                                                            .topicId),
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Text(controller
                                                    .listAllPost[index]
                                                    .content),
                                                const Gap(20),
                                                Image.file(File(controller
                                                    .listAllPost[index].image)),
                                                const Gap(10),
                                                Text(
                                                    "Posted date: ${controller.listAllPost[index].postedDate}"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  child: Container(
                                    //height: 200,
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
                                        Text((index + 1).toString()),
                                        const Gap(10),
                                        Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              child: Image(
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                                image: FileImage(File(controller
                                                    .listAllPost[index].image)),
                                              ),
                                            ),
                                            Positioned.fill(
                                              child: Align(
                                                alignment:
                                                    const Alignment(1.5, 1.5),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  child: CircleAvatar(
                                                    radius: 10,
                                                    // backgroundImage: AssetImage(
                                                    //     "assets/images/post1.jpg"),
                                                    backgroundImage: FileImage(
                                                        File(controller
                                                            .getAvatarByID(
                                                                controller
                                                                    .listAllPost[
                                                                        index]
                                                                    .userId))),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const Gap(10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(3),
                                                decoration: const BoxDecoration(
                                                    color: Colors.purple,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                child: Text(
                                                  controller.getTopicNameByID(
                                                      controller
                                                          .listAllPost[index]
                                                          .topicId),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                )),
                                            SizedBox(
                                              width: 230,
                                              child: Text(
                                                controller
                                                    .listAllPost[index].title,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        MyFontWeight.semiBold),
                                              ),
                                            ),
                                            Text(controller.getFullnameByID(
                                                controller.listAllPost[index]
                                                    .userId)),
                                          ],
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Get.defaultDialog(
                                                title:
                                                    "Do you want to delete this Post",
                                                content: Container(),
                                                textConfirm: "Confirm",
                                                confirmTextColor: Colors.white,
                                                buttonColor: MyColor.heartColor,
                                                textCancel: "Cancel",
                                                cancelTextColor:
                                                    MyColor.heartColor,
                                                titleStyle: TextStyle(
                                                  fontSize: 17,
                                                  color: MyColor.heartColor,
                                                  fontWeight: MyFontWeight.bold,
                                                ),
                                                titlePadding:
                                                    const EdgeInsets.all(20),
                                                backgroundColor: Colors.white,
                                                onConfirm: () {
                                                  controller.deletePost(
                                                      controller
                                                          .listAllPost[index]
                                                          .id);
                                                  Get.back();
                                                });
                                          },
                                          child: FaIcon(
                                            FontAwesomeIcons.squareXmark,
                                            color: MyColor.heartColor,
                                          ),
                                        )
                                      ],
                                    ),
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
