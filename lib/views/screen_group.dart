import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/controllers/groupcontroller.dart';
import 'package:petavinh/models/group.dart';
import 'package:petavinh/utils/samples.dart';
import 'package:petavinh/views/screen_inside_group.dart';

class ScreenGroup extends StatelessWidget {
  const ScreenGroup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GroupController());
    return GetBuilder<GroupController>(builder: (controller) {
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Row(
                    children: [
                      Text(
                        "Home",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: MyColor.mainColor),
                      ),
                      //Icon(FontAwesomeIcons.xmark),
                    ],
                  ),
                  onPressed: () {
                    Get.offAllNamed("/");
                  },
                ),
                title: const Text(
                  "Group",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: MyFontWeight.semiBold,
                  ),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Groups",
                            style: TextStyle(fontWeight: MyFontWeight.bold),
                          ),
                          Text(
                            "See All",
                            style: TextStyle(
                                color: MyColor.textHomeColor,
                                fontWeight: MyFontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 100,
                      child: ListView.builder(
                        itemCount: controller.listGroup.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 100,
                              height: 100,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: InnerShadow(
                                      shadows: [
                                        Shadow(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            blurRadius: 19,
                                            offset: const Offset(0, -40))
                                      ],
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.file(
                                          File(controller
                                              .listGroup[index].groupImage),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        controller.listGroup[index].groupName,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Gap(20),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: TabBar(
                        tabs: [
                          Tab(
                            text: "Explore group",
                          ),
                          Tab(
                            text: "Joined group",
                          ),
                          Tab(
                            text: "My group",
                          )
                        ],
                      ),
                    ),
                    const Gap(20),

                    // List Explore

                    SizedBox(
                      height: 700,
                      child: TabBarView(
                        children: [
                          // 1nd
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.getListGrNotJoined().length,
                            itemBuilder: (context, index) {
                              Group group =
                                  controller.getListGrNotJoined()[index];
                              return GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding:
                                      const EdgeInsets.only(left: 10, right: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.file(
                                            File(group.groupImage),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const Gap(5),
                                      SizedBox(
                                        width: 200,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              group.groupName,
                                              style: const TextStyle(
                                                overflow: TextOverflow.clip,
                                                fontSize: 15,
                                                fontWeight:
                                                    MyFontWeight.semiBold,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const FaIcon(
                                                  FontAwesomeIcons.userGroup,
                                                  size: 10,
                                                  color: Color.fromARGB(
                                                      255, 72, 72, 72),
                                                ),
                                                const Gap(5),
                                                Text(
                                                  '${controller.countMember(group.id)} members',
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      PopupMenuButton(
                                        surfaceTintColor: Colors.white,
                                        itemBuilder: (context) => [
                                          PopupMenuItem<String>(
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 300,
                                                    height: 100,
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: Image.file(
                                                      File(Sample.fileImage),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  const Gap(10),
                                                  SizedBox(
                                                    width: 300,
                                                    //height: 30,
                                                    child: Text(
                                                      group.groupName,
                                                      style: TextStyle(
                                                          color: MyColor
                                                              .bookMarkColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Rules:",
                                                    style: TextStyle(
                                                        color:
                                                            MyColor.heartColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    width: 300,
                                                    //height: 170,
                                                    child: Text(
                                                      group.rules,
                                                      maxLines: 5,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Description:",
                                                    style: TextStyle(
                                                        color:
                                                            MyColor.heartColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    width: 300,
                                                    //height: 170,
                                                    child: Text(
                                                      group.description,
                                                      maxLines: 9,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                        child: Icon(
                                          FontAwesomeIcons.circleInfo,
                                          size: 20,
                                          color: MyColor.bookMarkColor,
                                        ),
                                      ),
                                      const Gap(10),
                                      TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.all(0),
                                        ),
                                        child: Text(
                                          'Request',
                                          style: TextStyle(
                                              color: MyColor.bookMarkColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          // 2nd
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.getListGrJoined().length,
                            itemBuilder: (context, index) {
                              Group group = controller.getListGrJoined()[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(ScreenInsideGroup(
                                    groupId: group.id,
                                  ));
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding:
                                      const EdgeInsets.only(left: 10, right: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.file(
                                            File(group.groupImage),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const Gap(5),
                                      SizedBox(
                                        width: 200,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              group.groupName,
                                              style: const TextStyle(
                                                overflow: TextOverflow.clip,
                                                fontSize: 15,
                                                fontWeight:
                                                    MyFontWeight.semiBold,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const FaIcon(
                                                  FontAwesomeIcons.userGroup,
                                                  size: 10,
                                                  color: Color.fromARGB(
                                                      255, 72, 72, 72),
                                                ),
                                                const Gap(5),
                                                Text(
                                                  '${controller.countMember(group.id)} members',
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      PopupMenuButton(
                                        itemBuilder: (context) => [
                                          PopupMenuItem<String>(
                                            child: Container(
                                              padding: const EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 300,
                                                    height: 100,
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: Image.file(
                                                      File(Sample.fileImage),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  const Gap(10),
                                                  SizedBox(
                                                    width: 300,
                                                    //height: 30,
                                                    child: Text(
                                                      group.groupName,
                                                      style: TextStyle(
                                                          color: MyColor
                                                              .bookMarkColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Rules:",
                                                    style: TextStyle(
                                                        color:
                                                            MyColor.heartColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    width: 300,
                                                    //height: 170,
                                                    child: Text(
                                                      group.rules,
                                                      maxLines: 5,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Description:",
                                                    style: TextStyle(
                                                        color:
                                                            MyColor.heartColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    width: 300,
                                                    //height: 170,
                                                    child: Text(
                                                      group.description,
                                                      maxLines: 5,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                        child: Icon(
                                          FontAwesomeIcons.circleInfo,
                                          size: 20,
                                          color: MyColor.mainColor,
                                        ),
                                      ),
                                      const Gap(10),
                                      TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.all(0),
                                        ),
                                        child: Text(
                                          'Out group',
                                          style: TextStyle(
                                              color: MyColor.mainColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          // 3nd
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.getManageGroup().length,
                            itemBuilder: (context, index) {
                              Group group = controller.getManageGroup()[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.offAll(ScreenInsideGroup(
                                    groupId: group.id,
                                  ));
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding:
                                      const EdgeInsets.only(left: 10, right: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.file(
                                            File(group.groupImage),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const Gap(5),
                                      SizedBox(
                                        width: 200,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              group.groupName,
                                              style: const TextStyle(
                                                overflow: TextOverflow.clip,
                                                fontSize: 15,
                                                fontWeight:
                                                    MyFontWeight.semiBold,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const FaIcon(
                                                  FontAwesomeIcons.userGroup,
                                                  size: 10,
                                                  color: Color.fromARGB(
                                                      255, 72, 72, 72),
                                                ),
                                                const Gap(5),
                                                Text(
                                                  '${controller.countMember(group.id)} members',
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      PopupMenuButton(
                                        itemBuilder: (context) => [
                                          PopupMenuItem<String>(
                                            child: Container(
                                              padding: const EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 300,
                                                    height: 100,
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: Image.file(
                                                      File(Sample.fileImage),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  const Gap(10),
                                                  SizedBox(
                                                    width: 300,
                                                    //height: 30,
                                                    child: Text(
                                                      group.groupName,
                                                      style: TextStyle(
                                                          color: MyColor
                                                              .bookMarkColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Rules:",
                                                    style: TextStyle(
                                                        color:
                                                            MyColor.heartColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    width: 300,
                                                    //height: 170,
                                                    child: Text(
                                                      group.rules,
                                                      maxLines: 5,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Description:",
                                                    style: TextStyle(
                                                        color:
                                                            MyColor.heartColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    width: 300,
                                                    //height: 170,
                                                    child: Text(
                                                      group.description,
                                                      maxLines: 5,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                        child: Icon(
                                          FontAwesomeIcons.circleInfo,
                                          size: 20,
                                          color: MyColor.heartColor,
                                        ),
                                      ),
                                      const Gap(10),
                                      TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.all(0),
                                        ),
                                        child: Text(
                                          'Remove',
                                          style: TextStyle(
                                              color: MyColor.heartColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
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
