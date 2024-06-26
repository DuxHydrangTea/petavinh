import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/controllers/admin/useradmincontroller.dart';
import 'package:petavinh/views/admin/components/admin_drawer.dart';

class ScreenAdminUser extends StatelessWidget {
  const ScreenAdminUser({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserAdminController());
    return GetBuilder<UserAdminController>(builder: (controller) {
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
                                "User table",
                                style: TextStyle(
                                  fontWeight: MyFontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text("See all"),
                            ],
                          ),
                          const Gap(10),
                          GestureDetector(
                            onTap: () => showModalBottomSheet(
                              useSafeArea: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(30),
                                child: Scaffold(
                                  appBar: AppBar(),
                                  body: SingleChildScrollView(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Obx(() =>
                                              controller.image.value.path == ""
                                                  ? Container()
                                                  : Image.file(File(controller
                                                      .image.value.path))),
                                          const Gap(10),
                                          GestureDetector(
                                            onTap: () {
                                              controller.imagePicker(
                                                  ImageSource.gallery);
                                            },
                                            child: const Row(
                                              children: [
                                                FaIcon(FontAwesomeIcons.image),
                                                Gap(5),
                                                Text("Choose image"),
                                              ],
                                            ),
                                          ),
                                          TextFormField(
                                            controller:
                                                controller.txtAddUsername,
                                            decoration: const InputDecoration(
                                                label: Text("Username")),
                                          ),
                                          TextFormField(
                                            controller:
                                                controller.txtAddFullname,
                                            decoration: const InputDecoration(
                                                label: Text("Fullname")),
                                          ),
                                          TextFormField(
                                            controller:
                                                controller.txtAddPassword,
                                            decoration: const InputDecoration(
                                                label: Text("Password")),
                                          ),
                                          TextFormField(
                                            controller: controller.txtAddBio,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: 10,
                                            decoration: const InputDecoration(
                                                label: Text("Bio")),
                                          ),
                                          const Gap(10),
                                          GestureDetector(
                                            onTap: () {
                                              controller.addUser();
                                              Get.back();
                                            },
                                            child: Container(
                                              width: 80,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: const Center(
                                                  child: Text(
                                                "Add",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: MyColor.bookMarkColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text(
                                "Add user",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          //// listttttt user ////
                          SizedBox(
                            height: 700,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.listUser.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        padding: const EdgeInsets.all(20),
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 70,
                                              backgroundImage: FileImage(
                                                File(controller
                                                    .listUser[index].avatar),
                                              ),
                                            ),
                                            const Gap(20),
                                            Text(
                                              controller
                                                  .listUser[index].fullname,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight:
                                                      MyFontWeight.semiBold),
                                            ),
                                            Text(
                                              "Joined time: ${controller.listUser[index].joinedTime}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight:
                                                      MyFontWeight.medium),
                                            ),
                                            const Gap(20),
                                            Text(
                                              "Bio: ${controller.listUser[index].description}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight:
                                                      MyFontWeight.normal),
                                            ),
                                          ],
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
                                        Text((controller.listUser[index].id)
                                            .toString()),
                                        const Gap(10),
                                        CircleAvatar(
                                          backgroundImage: FileImage(File(
                                              controller
                                                  .listUser[index].avatar)),
                                        ),
                                        const Gap(10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                controller.listUser[index]
                                                            .isAdmin ==
                                                        1
                                                    ? const FaIcon(
                                                        FontAwesomeIcons
                                                            .solidUser,
                                                        size: 12,
                                                      )
                                                    : Container(),
                                                const Gap(10),
                                                Text(
                                                  controller
                                                      .listUser[index].fullname,
                                                  style: const TextStyle(
                                                      fontWeight: MyFontWeight
                                                          .semiBold),
                                                ),
                                              ],
                                            ),
                                            Text(
                                                "@${controller.listUser[index].username}"),
                                          ],
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Get.defaultDialog(
                                                title:
                                                    "Do you want to delete this user",
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
                                                  controller.onDeleteUser(
                                                      controller
                                                          .listUser[index].id);
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
