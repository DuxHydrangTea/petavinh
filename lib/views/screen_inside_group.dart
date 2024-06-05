import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myeffect.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/controllers/insidegroupcontroller.dart';
import 'package:petavinh/models/post.dart';
import 'package:petavinh/models/topic.dart';
import 'package:petavinh/models/user.dart';
import 'package:petavinh/utils/mytime.dart';
import 'package:petavinh/views/components/container_border.dart';
import 'package:petavinh/views/components/detailpost_components/list_comments.dart';
import 'package:petavinh/views/components/my_hero.dart';
import 'package:petavinh/views/screen_approve_group.dart';
import 'package:petavinh/views/screen_member_manager.dart';
import 'package:petavinh/views/screen_post.dart';
import 'package:readmore/readmore.dart';

// ignore: must_be_immutable
class ScreenInsideGroup extends StatelessWidget {
  int groupId;
  ScreenInsideGroup({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    Get.put(InsideGroupController(groupId: groupId));
    return GetBuilder<InsideGroupController>(
      builder: (controller) {
        //controller.groupId = groupId;

        return RefreshIndicator(
          onRefresh: () async {
            controller.onInit();
          },
          child: Scaffold(
            body: SafeArea(
              child: ListView(
                children: [
                  Row(children: [
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.xmark),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    const Spacer(),
                    Text(
                      controller.group.groupName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        controller.outGroupAction();
                      },
                      child: Text(
                        "Out",
                        style: TextStyle(
                          color: MyColor.heartColor,
                        ),
                      ),
                    ),
                    const Gap(10),
                  ]),
                  Image.file(
                      fit: BoxFit.cover,
                      height: 200,
                      File(controller.group.groupImage)),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  controller.group.groupName,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: MyColor.mainColor,
                                  ),
                                ),
                                const Gap(10),
                                FaIcon(
                                  FontAwesomeIcons.chevronRight,
                                  size: 15,
                                  color: MyColor.mainColor,
                                ),
                              ],
                            ),
                            const Gap(5),
                            Row(
                              children: [
                                const Gap(10),
                                const Icon(
                                  FontAwesomeIcons.userGroup,
                                  size: 11,
                                  color: Colors.grey,
                                ),
                                const Gap(10),
                                InkWell(
                                  onTap: () {
                                    Get.to(ScreenMemberManager(
                                      groupId: groupId,
                                    ));
                                  },
                                  child: Text(
                                    '${controller.listMember.where((element) => element.approve == 1).toList().length} members',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Gap(10),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEEEDF2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: InkWell(
                              onTap: () => showModalBottomSheet(
                                enableDrag: true,
                                isScrollControlled: true,
                                context: context,
                                //
                                //
                                // SHEET WRITE POST
                                //
                                //
                                builder: (context) => Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Scaffold(
                                      appBar: AppBar(),
                                      body: SingleChildScrollView(
                                        child: SafeArea(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ContainerBorder(
                                                      child: CircleAvatar(
                                                        radius: 20,
                                                        backgroundImage:
                                                            Image.file(File(
                                                                    controller
                                                                        .myUser
                                                                        .avatar))
                                                                .image,
                                                      ),
                                                    ),
                                                    const Gap(10),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                MyFontWeight
                                                                    .semiBold,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Obx(() => Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                ),
                                                                height: 30,
                                                                //width: 215,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                        color: Color(
                                                                            0xff9B7DEE),
                                                                        border:
                                                                            Border(),
                                                                        borderRadius:
                                                                            BorderRadius
                                                                                .all(
                                                                          Radius.circular(
                                                                              5),
                                                                        )),
                                                                child:
                                                                    DropdownButton(
                                                                  iconEnabledColor:
                                                                      Colors
                                                                          .white,
                                                                  dropdownColor:
                                                                      const Color(
                                                                          0xff9B7DEE),
                                                                  underline:
                                                                      Container(),
                                                                  value: controller
                                                                      .wIdTopic
                                                                      .value,
                                                                  hint: const Text(
                                                                      "Choose any topic.."),
                                                                  onChanged: (int?
                                                                      valueN) {
                                                                    controller
                                                                        .changeWriteIdTopic(
                                                                            valueN!);
                                                                  },
                                                                  items: controller
                                                                      .listTopic
                                                                      .map((e) =>
                                                                          DropdownMenuItem(
                                                                            value:
                                                                                e.id,
                                                                            child:
                                                                                Text(
                                                                              e.topicname!,
                                                                              style: const TextStyle(color: Colors.white),
                                                                            ),
                                                                          ))
                                                                      .toList(),
                                                                ))),
                                                            const Gap(10),
                                                            GestureDetector(
                                                              onTap: () {
                                                                controller.imagePicker(
                                                                    ImageSource
                                                                        .gallery);
                                                              },
                                                              child:
                                                                  const FaIcon(
                                                                size: 30,
                                                                FontAwesomeIcons
                                                                    .image,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const Gap(10),
                                                Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 12,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    5)),
                                                        border: Border.all(
                                                          color: const Color(
                                                              0xffD9D9D9),
                                                        )),
                                                    child: TextFormField(
                                                      controller: controller
                                                          .titleController,
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText:
                                                            "Text your title",
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    )),
                                                const Gap(10),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 12,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  5)),
                                                      border: Border.all(
                                                        color: const Color(
                                                            0xffD9D9D9),
                                                      )),
                                                  child: TextFormField(
                                                    controller: controller
                                                        .contentController,
                                                    maxLines: 10,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          "Text your content",
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                                const Gap(10),
                                                Obx(
                                                  () => controller.image.value
                                                              .path !=
                                                          ""
                                                      ? Image.file(controller
                                                          .image.value)

                                                      ///data/user/0/com.example.petavinh/cache/d2fdac33-f36c-425e-821a-1b9e5f3307fe/2020-07-28.jpg
                                                      : Container(),
                                                ),
                                                const Gap(10),
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.onPost();
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    height: 40,
                                                    width: 100,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                    ),
                                                    child: const Center(
                                                        child: Text(
                                                      "Post",
                                                      style: TextStyle(
                                                        fontWeight: MyFontWeight
                                                            .semiBold,
                                                        color: Colors.white,
                                                      ),
                                                    )),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  //Avatar
                                  SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircleAvatar(
                                      backgroundImage: FileImage(
                                        File(controller.myUser.avatar),
                                      ),
                                      radius: 5,
                                    ),
                                  ),
                                  const Gap(10),
                                  //Text
                                  const Text("How do your pet today ?"),
                                  const Spacer(),
                                  const Icon(FontAwesomeIcons.image),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Gap(20),
                        controller.isAdmin() == true
                            ? GestureDetector(
                                onTap: () {
                                  Get.to(ScreenApproveGroup(
                                    groupId: groupId,
                                  ));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: MyColor.bookMarkColor,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: const Row(
                                    children: [
                                      Text("List requests! "),
                                      Text(
                                        "Approve",
                                        style: TextStyle(
                                          fontWeight: MyFontWeight.semiBold,
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        const Gap(20),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.getListApprove().length,
                        itemBuilder: (context, index) {
                          Post post = controller.getListApprove()[index];
                          //return const Text("data");
                          User user = controller.getUser(post.userId);

                          Topic topic = controller.getTopic(post.topicId);
                          //print(topic.topicname);
                          return GestureDetector(
                            onTap: () {
                              Get.to(ScreenPost(
                                post: post,
                              ));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration:
                                  MyEffect.getBoxRadiusShadown(5, Colors.white),
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // header Show name user
                                  Row(
                                    children: [
                                      ContainerBorder(
                                        child: CircleAvatar(
                                          backgroundImage:
                                              Image.file(File(user.avatar))
                                                  .image,
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
                                                MyTime.diffTime(
                                                    post.postedDate),
                                                style: TextStyle(
                                                    color:
                                                        MyColor.outlineColor),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      PopupMenuButton(
                                          color: Colors.white,
                                          icon: const FaIcon(FontAwesomeIcons
                                              .ellipsisVertical),
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
                                                          color: MyColor
                                                              .heartColor,
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
                                    trimCollapsedText: '...Show more ->',
                                    trimExpandedText: '   <- Show less',
                                  ),
                                  const Gap(5),
                                  // image
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => MyHeroAlbum(
                                            tag: post.image,
                                            description: post.content,
                                          ));
                                    },
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton.icon(
                                          onPressed: () {
                                            controller.likeAction(post.id);
                                          },
                                          style: TextButton.styleFrom(
                                              padding: const EdgeInsets.all(0)),
                                          icon: FaIcon(
                                            controller.isLiked(post.id)
                                                ? FontAwesomeIcons.solidHeart
                                                : FontAwesomeIcons.heart,
                                            color: Colors.black,
                                          ),
                                          label: Text(
                                            "${controller.countReact(post.id)} reacts",
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          )),
                                      TextButton.icon(
                                          onPressed: () => showModalBottomSheet(
                                                enableDrag: true,
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (context) => Scaffold(
                                                  body: SingleChildScrollView(
                                                    child: SafeArea(
                                                        child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 35,
                                                          horizontal: 10),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                            child: const FaIcon(
                                                                FontAwesomeIcons
                                                                    .arrowLeft),
                                                          ),
                                                          ListComments(
                                                            listComment: [
                                                              ...controller
                                                                  .getListComment(
                                                                      post.id)
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                          style: TextButton.styleFrom(
                                              padding: const EdgeInsets.all(0)),
                                          icon: const FaIcon(
                                            FontAwesomeIcons.comment,
                                            color: Colors.black,
                                          ),
                                          label: Text(
                                            "${controller.countComment(post.id)} comments",
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          )),
                                      TextButton.icon(
                                          onPressed: () {
                                            controller.saveAction(post.id);
                                          },
                                          style: TextButton.styleFrom(
                                              padding: const EdgeInsets.all(0)),
                                          icon: FaIcon(
                                            controller.isSaved(post.id)
                                                ? FontAwesomeIcons.solidBookmark
                                                : FontAwesomeIcons.bookmark,
                                            color: Colors.black,
                                          ),
                                          label: Text(
                                            "${controller.countSave(post.id)} saves",
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
