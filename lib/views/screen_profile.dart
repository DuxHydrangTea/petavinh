import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myeffect.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/controllers/profilecontroller.dart';
import 'package:petavinh/utils/samples.dart';
import 'package:petavinh/views/components/container_border.dart';
import 'package:petavinh/views/components/my_hero.dart';
import 'package:petavinh/views/components/profile_components/album_tab.dart';
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
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: MyColor.mainColor,
                          width: 2,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                              MyHeroAlbum(tag: controller.userProfile.avatar));
                        },
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage:
                              Image.file(File(controller.userProfile.avatar))
                                  .image,
                        ),
                      ),
                    ),
                    // change avatar
                    Positioned(
                        child: Container(
                      decoration: BoxDecoration(
                          color: MyColor.mainColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                      child: IconButton(
                        onPressed: () {
                          controller.changeAvatar();
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.camera,
                          color: Colors.white,
                        ),
                      ),
                    ))
                  ],
                ),
                const Gap(20),
                Text(
                  controller.userProfile.fullname,
                  style: const TextStyle(
                    fontWeight: MyFontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "@${controller.userProfile.username}",
                  style: const TextStyle(fontSize: 19),
                ),
                const Gap(30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.userProfile.description,
                        style: const TextStyle(
                          fontWeight: MyFontWeight.medium,
                          letterSpacing: 1,
                          wordSpacing: 0.2,
                          decorationThickness: 5,
                        ),
                      ),
                      const Gap(10),
                      SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: null,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                MyColor.bookMarkColor),
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () => showModalBottomSheet(
                              enableDrag: true,
                              //isScrollControlled: true,
                              context: context,
                              builder: (context) => Scaffold(
                                appBar: AppBar(
                                  actions: [
                                    const Text(
                                      "Clear",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: MyFontWeight.bold,
                                      ),
                                    ),
                                    const Gap(10),
                                    GestureDetector(
                                      onTap: () {
                                        controller.updateBio();
                                      },
                                      child: const Text(
                                        "Change",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: MyFontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Gap(20),
                                  ],
                                ),
                                body: SingleChildScrollView(
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: controller.bioController,
                                          minLines: 1,
                                          maxLines: 15,
                                          keyboardType: TextInputType.multiline,
                                          decoration: const InputDecoration(
                                            labelText: "Bio",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            child: const Text(
                              "Edit",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Row(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.clock,
                            size: 14,
                          ),
                          const Gap(10),
                          Text("Joined at ${controller.userProfile.joinedTime}")
                        ],
                      )
                    ],
                  ),
                ),
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
                          label: "Bạn follow",
                          isSelect: controller.selectTab == 2,
                          onPress: () {
                            controller.changeSelectTab(2);
                          },
                        ),
                        TabItem(
                          label: "Follow bạn",
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
                    ? AlbumTab(album: controller.album)
                    : Container(),
                controller.selectTab == 1
                    ? PostTab(
                        listPost: controller.listMyPosts,
                        listComment: [Sample.comment])
                    : Container(),
                controller.selectTab == 2
                    ? SizedBox(
                        height: 730,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: ContainerBorder(
                                  child: CircleAvatar(
                                    backgroundImage: FileImage(File(controller
                                        .listUserMeFollow[index].avatar)),
                                  ),
                                ),
                                title: Text(controller
                                    .listUserMeFollow[index].fullname),
                                subtitle: Text(
                                    "@${controller.listUserMeFollow[index].username}"),
                                trailing: GestureDetector(
                                    onTap: () {
                                      controller.unfollow(controller
                                          .listUserMeFollow[index].id);
                                    },
                                    child: const FaIcon(FontAwesomeIcons.x)),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemCount: controller.listUserMeFollow.length),
                      )
                    : Container(),
                controller.selectTab == 3
                    ? SizedBox(
                        height: 730,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: ContainerBorder(
                                  child: CircleAvatar(
                                    backgroundImage: FileImage(File(controller
                                        .listUserFollowMe[index].avatar)),
                                  ),
                                ),
                                title: Text(controller
                                    .listUserFollowMe[index].fullname),
                                subtitle: Text(
                                    "@${controller.listUserFollowMe[index].username}"),
                                trailing: GestureDetector(
                                    onTap: () {
                                      controller.removeFollow(controller
                                          .listUserFollowMe[index].id);
                                    },
                                    child: const FaIcon(FontAwesomeIcons.x)),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemCount: controller.listUserFollowMe.length),
                      )
                    : Container(),
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
