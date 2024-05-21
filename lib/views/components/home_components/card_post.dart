import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myeffect.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/models/comment.dart';
import 'package:petavinh/models/post.dart';
import 'package:petavinh/utils/mytime.dart';
import 'package:petavinh/views/components/container_border.dart';
import 'package:petavinh/views/screen_post.dart';

// ignore: must_be_immutable
class CardPost extends StatelessWidget {
  Post post;
  List<Comment> listCmt;
  CardPost({super.key, required this.post, required this.listCmt});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ScreenPost(
              post: post,
              listComment: listCmt,
            ));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: MyEffect.getBoxRadiusShadown(8, Colors.white),
        width: 320,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.file(
                      File(post.image),
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Positioned(
                      top: 10,
                      left: 10,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(0)),
                            alignment: Alignment.center,
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(174, 0, 0, 0)),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                          onPressed: null,
                          child: Icon(
                            size: 20,
                            FontAwesomeIcons.heart,
                            color: Colors.white,
                          ),
                        ),
                      ))
                ],
              ),
              const Gap(10),
              Row(
                children: [
                  Text(
                    post.topicname,
                    style: TextStyle(fontSize: 11, color: MyColor.outlineColor),
                  ),
                  const Spacer(),
                  Text(
                    MyTime.diffTime(post.postedDate),
                    style: TextStyle(
                      color: MyColor.textHomeColor,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(fontWeight: MyFontWeight.semiBold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ContainerBorder(
                        child: CircleAvatar(
                          radius: 10,
                          backgroundImage: Image.file(File(post.avatar)).image,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        post.fullname,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: MyFontWeight.medium,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                          onPressed: null,
                          style: const ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(0))),
                          icon: FaIcon(
                            FontAwesomeIcons.solidHeart,
                            color: MyColor.heartColor,
                            size: 13,
                          ),
                          label: Text(
                            post.numCmt.toString(),
                            style: TextStyle(color: MyColor.heartColor),
                          )),
                      const Gap(5),
                      TextButton.icon(
                          onPressed: null,
                          style: const ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(0))),
                          icon: FaIcon(
                            FontAwesomeIcons.solidBookmark,
                            color: MyColor.bookMarkColor,
                            size: 13,
                          ),
                          label: Text(
                            post.numSave.toString(),
                            style: TextStyle(color: MyColor.bookMarkColor),
                          )),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
