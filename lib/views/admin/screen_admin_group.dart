import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/controllers/admin/groupadmincontroller.dart';
import 'package:petavinh/models/user.dart';
import 'package:petavinh/views/admin/components/admin_drawer.dart';

class ScreenAdminGroup extends StatelessWidget {
  const ScreenAdminGroup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GroupAdminController());
    return GetBuilder<GroupAdminController>(builder: (controller) {
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
                          "Dashboard",
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
                                "Group table",
                                style: TextStyle(
                                  fontWeight: MyFontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text("See all"),
                            ],
                          ),
                          const Gap(10),

                          const Gap(10),
                          //// listttttt user ////
                          SizedBox(
                            height: 700,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.listGroup.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => showModalBottomSheet(
                                    useSafeArea: true,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return Scaffold(
                                        appBar: AppBar(),
                                        body: SingleChildScrollView(
                                          child: Container(
                                            padding: const EdgeInsets.all(20),
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  child: Image.file(File(
                                                      controller
                                                          .listGroup[index]
                                                          .groupImage)),
                                                ),
                                                const Gap(20),
                                                Text(
                                                  controller.listGroup[index]
                                                      .groupName,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: MyFontWeight
                                                          .semiBold),
                                                ),
                                                const Gap(20),
                                                const Divider(),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Date:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: MyColor
                                                              .heartColor),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        " ${controller.listGroup[index].createdTime}",
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                MyFontWeight
                                                                    .normal),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Divider(),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Rules:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: MyColor
                                                              .heartColor),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        " ${controller.listGroup[index].rules}",
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                MyFontWeight
                                                                    .normal),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Divider(),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Description:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: MyColor
                                                              .heartColor),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        " ${controller.listGroup[index].description}",
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                MyFontWeight
                                                                    .normal),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Divider(),
                                                Text(
                                                  "Members:",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          MyColor.heartColor),
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: ListView.builder(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    shrinkWrap: true,
                                                    itemCount: controller
                                                        .getListMember(
                                                            controller
                                                                .listGroup[
                                                                    index]
                                                                .id)
                                                        .length,
                                                    itemBuilder: (context, id) {
                                                      User us = controller
                                                          .getListMember(
                                                              controller
                                                                  .listGroup[
                                                                      index]
                                                                  .id)[id];
                                                      return Row(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundImage:
                                                                FileImage(
                                                              File(us.avatar),
                                                            ),
                                                          ),
                                                          const Gap(10),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    us.fullname,
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                  const Gap(10),
                                                                  controller.isAdmin(
                                                                          controller
                                                                              .listGroup[index]
                                                                              .id,
                                                                          us.id)
                                                                      ? Text(
                                                                          "Admin",
                                                                          style: TextStyle(
                                                                              color: MyColor.bookMarkColor,
                                                                              fontWeight: MyFontWeight.medium),
                                                                        )
                                                                      : Container(),
                                                                ],
                                                              ),
                                                              Text(
                                                                  "@${us.username}"),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  child: Container(
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
                                        Text((controller.listGroup[index].id)
                                            .toString()),
                                        const Gap(10),
                                        CircleAvatar(
                                          backgroundImage: FileImage(File(
                                              controller.listGroup[index]
                                                  .groupImage)),
                                        ),
                                        const Gap(10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  controller.listGroup[index]
                                                      .groupName,
                                                  style: const TextStyle(
                                                      fontWeight: MyFontWeight
                                                          .semiBold),
                                                ),
                                              ],
                                            ),
                                            Text(
                                                "${controller.getListMember(controller.listGroup[index].id).length} members"),
                                          ],
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Get.defaultDialog(
                                                title:
                                                    "Do you want to delete this group",
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
