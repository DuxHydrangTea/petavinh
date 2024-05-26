import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/controllers/homecontroller.dart';
import 'package:petavinh/models/post.dart';
import 'package:petavinh/models/topic.dart';
import 'package:petavinh/views/components/container_border.dart';
import 'package:petavinh/views/components/home_components/card_post.dart';
import 'package:petavinh/views/components/home_components/chip_item.dart';
import 'package:petavinh/views/components/home_components/headerhome.dart';
import 'package:petavinh/views/components/home_components/listchip_bar.dart';
import 'package:petavinh/views/components/home_components/post_group_item.dart';
import 'package:petavinh/views/components/home_components/post_item.dart';
import 'package:petavinh/views/components/listSelect/mylistchip.dart';
import 'package:petavinh/views/components/my_drawer.dart';
// ignore: unused_import
import 'package:readmore/readmore.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    List<Topic> listRangePost = MyListChip.getRangeChip();
    return GetBuilder<HomeController>(
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async {
            controller.onInit();
          },
          child: Scaffold(
            key: controller.scaffoldKey,
            endDrawer: Drawer(
              child: MyDrawer(
                onPressLogOut: () {
                  controller.logout();
                },
                user: controller.userProfile,
              ),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                  child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    HeaderHome(
                      logout: () {
                        controller.logout();
                      },
                      helloUsername: controller.userProfile.fullname,
                      avatar: controller.userProfile.avatar,
                      onDrawer: () {
                        controller.openDrawer();
                      },
                      showSheet: () => showModalBottomSheet(
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
                                                radius: 24,
                                                backgroundImage: Image.file(
                                                        File(controller
                                                            .userProfile
                                                            .avatar))
                                                    .image,
                                              ),
                                            ),
                                            const Gap(10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller
                                                      .userProfile.fullname,
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        MyFontWeight.semiBold,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Obx(() => Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10,
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
                                                                  Radius
                                                                      .circular(
                                                                          5),
                                                                )),
                                                        child: DropdownButton(
                                                          iconEnabledColor:
                                                              Colors.white,
                                                          dropdownColor:
                                                              const Color(
                                                                  0xff9B7DEE),
                                                          underline:
                                                              Container(),
                                                          value: controller
                                                              .wIdTopic.value,
                                                          hint: const Text(
                                                              "Choose any topic.."),
                                                          onChanged:
                                                              (int? valueN) {
                                                            controller
                                                                .changeWriteIdTopic(
                                                                    valueN!);
                                                          },
                                                          items: controller
                                                              .listTopic
                                                              .map((e) =>
                                                                  DropdownMenuItem(
                                                                    value: e.id,
                                                                    child: Text(
                                                                      e.topicname!,
                                                                      style: const TextStyle(
                                                                          color:
                                                                              Colors.white),
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
                                                      child: const FaIcon(
                                                        size: 30,
                                                        FontAwesomeIcons.image,
                                                        color: Colors.green,
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
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                border: Border.all(
                                                  color:
                                                      const Color(0xffD9D9D9),
                                                )),
                                            child: TextFormField(
                                              controller:
                                                  controller.titleController,
                                              decoration: const InputDecoration(
                                                hintText: "Text your title",
                                                border: InputBorder.none,
                                              ),
                                            )),
                                        const Gap(10),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              border: Border.all(
                                                color: const Color(0xffD9D9D9),
                                              )),
                                          child: TextFormField(
                                            controller:
                                                controller.contentController,
                                            maxLines: 10,
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration: const InputDecoration(
                                              hintText: "Text your content",
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        const Gap(10),
                                        Obx(
                                          () => controller.image.value.path !=
                                                  ""
                                              ? Image.file(
                                                  controller.image.value)

                                              ///data/user/0/com.example.petavinh/cache/d2fdac33-f36c-425e-821a-1b9e5f3307fe/2020-07-28.jpg
                                              : Container(),
                                        ),
                                        const Gap(10),
                                        GestureDetector(
                                          onTap: () {
                                            controller.onPost();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            height: 40,
                                            width: 100,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Colors.green,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                            ),
                                            child: const Center(
                                                child: Text(
                                              "Post",
                                              style: TextStyle(
                                                fontWeight:
                                                    MyFontWeight.semiBold,
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
                    ),
                    const Gap(10),
                    ListChipBar(
                      label: "Ratest Posts",
                      children: [
                        MyChip(
                          topic: Topic(
                            id: -1,
                            topicname: "All",
                            description: "Nothing",
                          ),
                          seleted: controller.selectedCategory,
                          onTap: () {
                            controller.updateSelectCategory(-1);
                          },
                        ),
                        ...controller.listTopic.map((e) => MyChip(
                              topic: Topic(id: e.id, topicname: e.topicname),
                              seleted: controller.selectedCategory,
                              onTap: () {
                                controller.updateSelectCategory(e.id);
                              },
                            ))
                      ],
                    ),
                    const Gap(7),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        height: 350,
                        //width: double.infinity,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.listRatestPost.length,
                            itemBuilder: (context, index) {
                              Post post = controller.listRatestPost[index];
                              return CardPost(
                                post: post,
                                countLike: controller.getCountReact(post.id),
                                countSave: controller.getCountSave(post.id),
                              );
                            }),
                      ),
                    ),
                    const Gap(7),
                    ListChipBar(
                      label: "Explore",
                      children: [
                        ...listRangePost.map((e) => MyChip(
                              topic: Topic(id: e.id, topicname: e.topicname),
                              seleted: controller.selectedLocal,
                              onTap: () {
                                controller.updateSelectLocal(e.id);
                              },
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          //
                          ...controller.listPostHome.map((e) => e.groupId == 0
                              ? PostItem(
                                  post: e,
                                  listComment:
                                      controller.getListCommentByID(e.id),
                                  isLike: controller.listLiked.contains(e.id),
                                  isSave: controller.listSavedByUserID
                                      .contains(e.id),
                                  countSave: controller.getCountSave(e.id),
                                  countReact: controller.getCountReact(e.id),
                                  onPressLike: () {
                                    controller.likeAction(e.id);
                                  },
                                  onPressSave: () {
                                    controller.saveAction(e.id);
                                  },
                                  isFollowed: controller.listUserMeFollow
                                      .contains(e.userId),
                                  onFollow: () {
                                    controller.unfollow(e.userId);
                                  },
                                )
                              : PostGroupItem(
                                  post: e,
                                  listComment:
                                      controller.getListCommentByID(e.id),
                                  onPressLike: () {
                                    controller.likeAction(e.id);
                                  },
                                  onPressSave: () {
                                    controller.saveAction(e.id);
                                  },
                                  countSave: controller.getCountSave(e.id),
                                  countReact: controller.getCountReact(e.id),
                                  isLike: controller.listLiked.contains(e.id),
                                  isSave: controller.listSavedByUserID
                                      .contains(e.id),
                                )),
                        ],
                      ),
                    )
                  ],
                ),
              )),
            ),
          ),
        );
      },
    );
  }
}
