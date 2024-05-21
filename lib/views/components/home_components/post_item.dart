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
import 'package:petavinh/views/components/detailpost_components/list_comments.dart';
import 'package:petavinh/views/components/my_hero.dart';
import 'package:petavinh/views/screen_post.dart';
import 'package:readmore/readmore.dart';

// ignore: must_be_immutable
class PostItem extends StatelessWidget {
  bool? isFollowed;
  Post post;
  List<Comment> listComment;
  bool isLike;
  bool isSave;
  int countReact;
  int countSave;
  VoidCallback onPressLike;
  VoidCallback onPressSave;

  PostItem({
    super.key,
    this.isFollowed = false,
    required this.post,
    required this.listComment,
    this.isLike = false,
    this.isSave = false,
    required this.countReact,
    required this.countSave,
    required this.onPressLike,
    required this.onPressSave,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ScreenPost(
          post: post,
          listComment: [...listComment],
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: MyEffect.getBoxRadiusShadown(5, Colors.white),
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header Show name user
            Row(
              children: [
                ContainerBorder(
                  child: CircleAvatar(
                    backgroundImage: Image.file(File(post.avatar)).image,
                    // backgroundImage: AssetImage("assets/images/avatar1.jpg"),
                  ),
                ),
                const Gap(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          post.fullname,
                          style: const TextStyle(fontWeight: MyFontWeight.bold),
                        ),
                        const Gap(5),
                        InkWell(
                            onTap: null,
                            child: Text(
                              isFollowed == false ? ".Follow" : ".Followed",
                              style: TextStyle(
                                  color: isFollowed == false
                                      ? MyColor.bookMarkColor
                                      : MyColor.heartColor,
                                  fontWeight: MyFontWeight.bold),
                            ))
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
                          MyTime.diffTime(post.postedDate),
                          style: TextStyle(color: MyColor.outlineColor),
                        ),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                PopupMenuButton(
                    color: Colors.white,
                    icon: const FaIcon(FontAwesomeIcons.ellipsisVertical),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              child: TextButton.icon(
                                  style: const ButtonStyle(
                                      padding: MaterialStatePropertyAll(
                                          EdgeInsets.zero)),
                                  onPressed: null,
                                  icon: FaIcon(
                                    FontAwesomeIcons.solidFlag,
                                    color: MyColor.bookMarkColor,
                                    size: 15,
                                  ),
                                  label: Text(
                                    "Report",
                                    style: TextStyle(
                                      color: MyColor.bookMarkColor,
                                    ),
                                  ))),
                          PopupMenuItem(
                              child: TextButton.icon(
                                  style: const ButtonStyle(
                                      padding: MaterialStatePropertyAll(
                                          EdgeInsets.zero)),
                                  onPressed: null,
                                  icon: FaIcon(
                                    FontAwesomeIcons.solidTrashCan,
                                    size: 15,
                                    color: MyColor.heartColor,
                                  ),
                                  label: Text(
                                    "Delete",
                                    style: TextStyle(
                                      color: MyColor.heartColor,
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
                    padding: MaterialStatePropertyAll(EdgeInsets.all(5)),
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xff9B7DEE)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ))),
                child: Text(
                  post.topicname,
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
              style: const TextStyle(fontWeight: MyFontWeight.semiBold),
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
                borderRadius: const BorderRadius.all(Radius.circular(5)),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                    onPressed: onPressLike,
                    style:
                        TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                    icon: FaIcon(
                      isLike
                          ? FontAwesomeIcons.solidHeart
                          : FontAwesomeIcons.heart,
                      color: Colors.black,
                    ),
                    label: Text(
                      countReact.toString(),
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 35, horizontal: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: const FaIcon(
                                          FontAwesomeIcons.arrowLeft),
                                    ),
                                    ListComments(
                                      listComment: listComment,
                                    ),
                                  ],
                                ),
                              )),
                            ),
                          ),
                        ),
                    style:
                        TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                    icon: const FaIcon(
                      FontAwesomeIcons.comment,
                      color: Colors.black,
                    ),
                    label: Text(
                      listComment.length.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    )),
                TextButton.icon(
                    onPressed: onPressSave,
                    style:
                        TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                    icon: FaIcon(
                      isSave == false
                          ? FontAwesomeIcons.bookmark
                          : FontAwesomeIcons.solidBookmark,
                      color: Colors.black,
                    ),
                    label: Text(
                      countSave.toString(),
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
  }
}
