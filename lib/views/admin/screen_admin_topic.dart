import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/controllers/admin/topicadmincontroller.dart';
import 'package:petavinh/views/admin/components/admin_drawer.dart';

class ScreenAdminTopic extends StatelessWidget {
  const ScreenAdminTopic({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TopicAdminController());
    return GetBuilder<TopicAdminController>(builder: (controller) {
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
                          InkWell(
                            onTap: () => showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: const FaIcon(
                                                FontAwesomeIcons.arrowLeft),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              controller.addTopic();
                                              Get.back();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                              ),
                                              child: const Text(
                                                "Confirm",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const Text(
                                        "Add a new topic",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: controller.txtAddTopicName,
                                        decoration: const InputDecoration(
                                          label: Text("Topic name..."),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: controller.txtAddDes,
                                        decoration: const InputDecoration(
                                          label: Text("Description..."),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: const Text(
                                "Add topic",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: MyFontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          //// listttttt user ////
                          SizedBox(
                            height: 700,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.listTopic.length,
                              itemBuilder: (context, index) {
                                controller.txtEditTopicName =
                                    TextEditingController(
                                        text: controller
                                            .listTopic[index].topicname!);
                                controller.txtEditTopicDes.text =
                                    controller.listTopic[index].description!;
                                controller.txtEditTopicId.text =
                                    controller.listTopic[index].id!.toString();
                                return GestureDetector(
                                  onTap: () => showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        padding: const EdgeInsets.all(30),
                                        child: Column(
                                          children: [
                                            Row(children: [
                                              const Text(
                                                "Edit topic",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const Spacer(),
                                              GestureDetector(
                                                onTap: () {
                                                  controller.editTopic();
                                                  Get.back();
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  child: const Text(
                                                    "Save",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            ]),
                                            TextFormField(
                                              controller:
                                                  controller.txtEditTopicName,
                                              decoration: const InputDecoration(
                                                label: Text("Topic name"),
                                              ),
                                            ),
                                            Visibility(
                                              visible: false,
                                              child: TextFormField(
                                                controller:
                                                    controller.txtEditTopicId,
                                              ),
                                            ),
                                            TextFormField(
                                              controller:
                                                  controller.txtEditTopicDes,
                                              decoration: const InputDecoration(
                                                label:
                                                    Text("Topic description"),
                                              ),
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
                                        Text((controller.listTopic[index].id)
                                            .toString()),
                                        const Gap(10),
                                        const Gap(10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  controller.listTopic[index]
                                                      .topicname!,
                                                  style: const TextStyle(
                                                      color: Colors.purple,
                                                      fontWeight:
                                                          MyFontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "${controller.listTopic[index].description}",
                                              style: const TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            ),
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
                                                  controller.deleteTopic(
                                                      controller
                                                          .listTopic[index]
                                                          .id!);
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
