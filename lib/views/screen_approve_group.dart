import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myeffect.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/controllers/groupapprovecontroller.dart';
import 'package:petavinh/models/post.dart';
import 'package:petavinh/models/topic.dart';
import 'package:petavinh/models/user.dart';
import 'package:petavinh/views/components/container_border.dart';
import 'package:readmore/readmore.dart';

class ScreenApproveGroup extends StatelessWidget {
  int groupId;
  ScreenApproveGroup({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    Get.put(GroupApproveController(groupId: groupId));
    return GetBuilder<GroupApproveController>(builder: (controller) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(),
          body: SafeArea(
              child: Column(
            children: [
              TabBar(
                indicatorColor: MyColor.bookMarkColor,
                labelColor: MyColor.bookMarkColor,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelColor: MyColor.commentColor,
                unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.normal),
                tabs: [
                  Tab(
                    icon: const Icon(FontAwesomeIcons.squarePen),
                    text: "Post - ${controller.listPost.length}",
                  ),
                  Tab(
                    icon: const Icon(FontAwesomeIcons.user),
                    text: "User - ${controller.listMember.length}",
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: 650,
                  child: TabBarView(children: [
                    //1st
                    ListView.builder(
                        itemCount: controller.listPost.length,
                        itemBuilder: (context, index) {
                          Post post = controller.listPost[index];
                          User user = controller.getUser(post.userId);
                          Topic topic = controller.getTopic(post.topicId);
                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration:
                                MyEffect.getBoxRadiusShadown(5, Colors.white),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // header Show name user
                                Row(
                                  children: [
                                    ContainerBorder(
                                      child: CircleAvatar(
                                        backgroundImage:
                                            Image.file(File(user.avatar)).image,
                                        // backgroundImage: AssetImage("assets/images/avatar1.jpg"),
                                      ),
                                    ),
                                    const Gap(8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              user.fullname,
                                              style: const TextStyle(
                                                  fontWeight:
                                                      MyFontWeight.bold),
                                            ),
                                            const Gap(5),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const FaIcon(
                                              FontAwesomeIcons.solidClock,
                                              size: 10,
                                              color: Color(0xff414141),
                                            ),
                                            const Gap(5),
                                            Text(
                                              //MyTime.diffTime(post.postedDate),
                                              "5 ago",
                                              style: TextStyle(
                                                  color: MyColor.outlineColor),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    PopupMenuButton(
                                        color: Colors.white,
                                        icon: const FaIcon(
                                            FontAwesomeIcons.ellipsisVertical),
                                        itemBuilder: (context) => [
                                              PopupMenuItem(
                                                  child: TextButton.icon(
                                                      style: const ButtonStyle(
                                                          padding:
                                                              MaterialStatePropertyAll(
                                                                  EdgeInsets
                                                                      .zero)),
                                                      onPressed: null,
                                                      icon: FaIcon(
                                                        FontAwesomeIcons
                                                            .solidFlag,
                                                        color: MyColor
                                                            .bookMarkColor,
                                                        size: 15,
                                                      ),
                                                      label: Text(
                                                        "Report",
                                                        style: TextStyle(
                                                          color: MyColor
                                                              .bookMarkColor,
                                                        ),
                                                      ))),
                                              PopupMenuItem(
                                                  child: TextButton.icon(
                                                      style: const ButtonStyle(
                                                          padding:
                                                              MaterialStatePropertyAll(
                                                                  EdgeInsets
                                                                      .zero)),
                                                      onPressed: null,
                                                      icon: FaIcon(
                                                        FontAwesomeIcons
                                                            .solidTrashCan,
                                                        size: 15,
                                                        color:
                                                            MyColor.heartColor,
                                                      ),
                                                      label: Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                          color: MyColor
                                                              .heartColor,
                                                        ),
                                                      ))),
                                            ]),
                                  ],
                                )
                                // show category
                                ,
                                const Gap(5),
                                SizedBox(
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: null,
                                    style: const ButtonStyle(
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsets.all(5)),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color(0xff9B7DEE)),
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ))),
                                    child: Text(
                                      topic.topicname!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: MyFontWeight.semiBold,
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(5),
                                // title
                                Text(
                                  post.title,
                                  style: const TextStyle(
                                      fontWeight: MyFontWeight.semiBold),
                                ),
                                const Gap(5),
                                // content
                                ReadMoreText(
                                  post.content,
                                  trimMode: TrimMode.Line,
                                  trimLines: 2,
                                  colorClickableText: Colors.pink,
                                  trimCollapsedText: 'Show more',
                                  trimExpandedText: '  Show less',
                                ),
                                const Gap(5),
                                // image
                                GestureDetector(
                                  onTap: () {},
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    //child: Image.file(File(post.image),
                                    child: Image.file(
                                      File(post.image),
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                // action
                                const Divider(),
                                Row(children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        controller.acceptPost(post.id);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: MyColor.bookMarkColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        height: 50,
                                        child: const Center(
                                            child: Text(
                                          "Accept",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        )),
                                      ),
                                    ),
                                  ),
                                  const Gap(10),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        controller.denyPost(post.id);
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: MyColor.heartColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: const Center(
                                            child: Text(
                                          "Deny",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        )),
                                      ),
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          );
                        }),

                    // user 2sd
                    Container(
                      child: SizedBox(
                        height: 690,
                        child: ListView.builder(
                            itemCount: controller.listMember.length,
                            itemBuilder: (context, index) {
                              User user = controller
                                  .getUser(controller.listMember[index].userId);
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
                                    Text(1.toString()),
                                    const Gap(10),
                                    CircleAvatar(
                                      backgroundImage:
                                          FileImage(File(user.avatar)),
                                    ),
                                    const Gap(10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              user.fullname,
                                              style: const TextStyle(
                                                  fontWeight:
                                                      MyFontWeight.semiBold),
                                            ),
                                          ],
                                        ),
                                        Text("@${user.fullname}"),
                                      ],
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        controller.acceptUser(user.id);
                                      },
                                      child: const FaIcon(
                                        FontAwesomeIcons.solidSquareCheck,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const Gap(10),
                                    GestureDetector(
                                      onTap: () {
                                        controller.denyUser(user.id);
                                      },
                                      child: FaIcon(
                                        FontAwesomeIcons.squareXmark,
                                        color: MyColor.heartColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ]),
                ),
              )
            ],
          )),
        ),
      );
    });
  }
}
