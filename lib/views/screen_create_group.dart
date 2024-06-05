import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/controllers/groupcreatecontroller.dart';

class ScreenCreateGroup extends StatelessWidget {
  const ScreenCreateGroup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GroupCreateController());
    return GetBuilder<GroupCreateController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Create new group"),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  //
                  //
                  Text(
                    "Name",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: MyColor.mainColor),
                  ),
                  TextFormField(
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      hintText: "Text your title",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyColor.mainColor,
                        ),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  //
                  //
                  const Gap(10),
                  //
                  Text(
                    "Rules",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: MyColor.mainColor),
                  ),
                  TextFormField(
                    controller: controller.rulesController,
                    maxLines: 7,
                    decoration: InputDecoration(
                      hintText: "Text your rules",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyColor.mainColor,
                        ),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  //
                  //
                  const Gap(10),
                  //
                  Text(
                    "Description",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: MyColor.mainColor),
                  ),
                  TextFormField(
                    controller: controller.descriptionController,
                    maxLines: 7,
                    decoration: InputDecoration(
                      hintText: "Text your description",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyColor.mainColor,
                        ),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  //
                  //
                  const Gap(10),
                  Text(
                    "Image",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: MyColor.mainColor),
                  ),
                  InkWell(
                    onTap: () {
                      controller.imagePicker(ImageSource.gallery);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: MyColor.bookMarkColor,
                      ),
                      child: const Text(
                        "Click here to choose any picture ",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const Gap(10),
                  controller.image.value.path == ""
                      ? Container()
                      : Image.file(File(controller.image.value.path)),

                  const Gap(10),
                  InkWell(
                    onTap: () {
                      controller.createGroup();
                      Get.back();
                    },
                    child: Container(
                      child: const Text("Create "),
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
