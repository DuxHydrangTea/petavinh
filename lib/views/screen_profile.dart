import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myeffect.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/controllers/profilecontroller.dart';
import 'package:petavinh/utils/samples.dart';
import 'package:petavinh/views/components/profile_components/album_tab.dart';
import 'package:petavinh/views/components/profile_components/bio_tab.dart';
import 'package:petavinh/views/components/profile_components/followed_tab.dart';
import 'package:petavinh/views/components/profile_components/followers_tab.dart';
import 'package:petavinh/views/components/profile_components/post_tab.dart';
import 'package:petavinh/views/components/profile_components/tab_items.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return GetBuilder<ProfileController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.x,
                        size: 20,
                        color: Color(0xff3f3f3f),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "Profile",
                      style: TextStyle(
                        fontWeight: MyFontWeight.semiBold,
                      ),
                    ),
                    const Spacer(),
                    const IconButton(
                      onPressed: null,
                      icon: FaIcon(
                        FontAwesomeIcons.heart,
                        color: Color(0xff3f3f3f),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: MyColor.mainColor,
                      width: 2,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage("assets/images/avatar1.jpg"),
                  ),
                ),
                const Gap(20),
                const Text(
                  "Nguyen Duc Dat",
                  style: TextStyle(
                    fontWeight: MyFontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const Text(
                  "@ducdat233",
                  style: TextStyle(fontSize: 19),
                ),
                const Gap(30),
                const BioTab(),
                const Gap(30),
                Container(
                  decoration: MyEffect.getBoxRadiusShadown(5, Colors.white),
                  padding: const EdgeInsets.all(0),
                  //color: const Color(0xffEFEFF1),
                  child: Expanded(
                    child: Row(
                      children: [
                        TabItem(
                          label: "Album",
                          isSelect: controller.selectTab == 0,
                          onPress: () {
                            controller.changeSelectTab(0);
                          },
                        ),
                        TabItem(
                          label: "Posts",
                          isSelect: controller.selectTab == 1,
                          onPress: () {
                            controller.changeSelectTab(1);
                          },
                        ),
                        TabItem(
                          label: "Followers",
                          isSelect: controller.selectTab == 2,
                          onPress: () {
                            controller.changeSelectTab(2);
                          },
                        ),
                        TabItem(
                          label: "Following",
                          isSelect: controller.selectTab == 3,
                          onPress: () {
                            controller.changeSelectTab(3);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(20),
                controller.selectTab == 0
                    ? AlbumTab(album: Sample.album)
                    : Container(),
                controller.selectTab == 1
                    ? PostTab(
                        listPost: [Sample.post], listComment: [Sample.comment])
                    : Container(),
                controller.selectTab == 2 ? const FollowedTab() : Container(),
                controller.selectTab == 3 ? const FollowersTab() : Container(),
                // =============== tab =======================
                // PostTab(
                //   listPost: [Sample.post],
                //   listComment: [Sample.comment],
                // )
                //
                //
                // AlbumTab(
                //   album: Sample.album,
                // ),
                //
                //
              ],
            ),
          ),
        )),
      );
    });
  }
}
