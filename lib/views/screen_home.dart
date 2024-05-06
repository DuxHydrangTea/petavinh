import 'package:flutter/material.dart';
import 'package:petavinh/controllers/homecontroller.dart';
import 'package:petavinh/models/topic.dart';
import 'package:petavinh/views/components/home_components/headerhome.dart';
import 'package:petavinh/views/components/home_components/chip_item.dart';
import 'package:petavinh/views/components/listSelect/mylistchip.dart';
import 'package:petavinh/views/components/home_components/list_post.dart';
import 'package:petavinh/views/components/home_components/listchip_bar.dart';
import 'package:gap/gap.dart';
import 'package:petavinh/views/components/home_components/ratest_post_card.dart';
import 'package:get/get.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    int selectChip = 2, exlore = 2;
    List<Topic> listRangePost = MyListChip.getRangeChip();
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
                child: Column(
              children: [
                const HeaderHome(),
                const Gap(10),
                ListChipBar(
                  label: "Ratest Posts",
                  children: [
                    MyChip(
                      topic: Topic(
                        id: 0,
                        topicname: "All",
                        description: "Nothing",
                      ),
                      seleted: controller.selectedCategory,
                      onTap: () {
                        controller.updateSelectCategory(0);
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
                controller.selectedCategory == 0
                    ? RatestPostCard(list: controller.listRatestPost)
                    : RatestPostCard(
                        list: controller.listRatestPost
                            .where((element) =>
                                element.topicId == controller.selectedCategory)
                            .toList(),
                      ),
                const Gap(7),
                ListChipBar(
                  label: "Explore",
                  children: [
                    MyChip(
                      topic: Topic(
                          id: 1, topicname: "All", description: "Nothing"),
                      seleted: exlore,
                    ),
                    ...listRangePost.map((e) => MyChip(
                          topic: Topic(id: e.id, topicname: e.topicname),
                          seleted: selectChip,
                        ))
                  ],
                ),
                ListPost(
                  listPost: [...controller.listAllPost],
                  listComment: [...controller.listComment],
                ),
              ],
            )),
          ),
        );
      },
    );
  }
}
