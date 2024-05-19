import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petavinh/controllers/homecontroller.dart';
import 'package:petavinh/models/topic.dart';
import 'package:petavinh/views/components/home_components/chip_item.dart';
import 'package:petavinh/views/components/home_components/headerhome.dart';
import 'package:petavinh/views/components/home_components/listchip_bar.dart';
import 'package:petavinh/views/components/home_components/post_group_item.dart';
import 'package:petavinh/views/components/home_components/post_item.dart';
import 'package:petavinh/views/components/home_components/ratest_post_card.dart';
import 'package:petavinh/views/components/listSelect/mylistchip.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    List<Topic> listRangePost = MyListChip.getRangeChip();
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
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
                    helloUsername: controller.username,
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
                  controller.selectedCategory == -1
                      ? RatestPostCard(
                          list: controller.listRatestPost,
                          listcmt: [...controller.listComment],
                        ).animate().moveX(
                            curve: Curves.easeInOut,
                            delay: const Duration(milliseconds: 400),
                            begin: 400,
                          )
                      : RatestPostCard(
                          list: controller.listRatestPost
                              .where((element) =>
                                  element.topicId ==
                                  controller.selectedCategory)
                              .toList(),
                          listcmt: [...controller.listComment],
                        ).animate().moveX(
                            curve: Curves.easeInOut,
                            delay: const Duration(milliseconds: 400),
                            begin: 400,
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
                        ...controller.getPostLocal().map((e) => e.groupId == 0
                            ? PostItem(
                                post: e,
                                listComment:
                                    controller.getListCommentByID(e.id),
                                isLike: controller.listLiked.contains(e.id),
                                isSave:
                                    controller.listSavedByUserID.contains(e.id),
                                countSave: controller.getCountSave(e.id),
                                countReact: controller.getCountReact(e.id),
                                onPressLike: () {
                                  controller.likeAction(e.id);
                                },
                                onPressSave: () {
                                  controller.saveAction(e.id);
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
                                isSave:
                                    controller.listSavedByUserID.contains(e.id),
                              )),
                      ],
                    ),
                  )
                ],
              ),
            )),
          ),
        );
      },
    );
  }
}
