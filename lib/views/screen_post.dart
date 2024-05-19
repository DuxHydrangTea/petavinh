import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/controllers/postcontroller.dart';
import 'package:petavinh/models/comment.dart';
import 'package:petavinh/models/post.dart';
import 'package:petavinh/utils/mytime.dart';
import 'package:petavinh/views/components/detailpost_components/comment_item.dart';
import 'package:petavinh/views/components/my_hero.dart';
import 'package:petavinh/views/sheet_list_comment.dart';

class ScreenPost extends StatelessWidget {
  Post post;
  List<Comment> listComment;
  ScreenPost({
    super.key,
    required this.post,
    required this.listComment,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(PostController());
    return GetBuilder<PostController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              //decoration: MyEffect.getBoxRadiusShadown(5, Colors.white),
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const FaIcon(FontAwesomeIcons.angleLeft),
                      )
                    ],
                  ),
                  // header Show name user
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(post.avatar),
                      ),
                      const Gap(8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                post.fullname,
                                style: const TextStyle(
                                    fontWeight: MyFontWeight.bold),
                              ),
                              const Gap(5),
                              InkWell(
                                  onTap: null,
                                  child: Text(
                                    ".Followed",
                                    style: TextStyle(
                                        color: MyColor.heartColor,
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
                          shape:
                              MaterialStatePropertyAll(RoundedRectangleBorder(
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
                  Text(post.content),
                  const Gap(5),
                  // image
                  GestureDetector(
                    onTap: () {
                      Get.to(() => MyHeroAlbum(tag: post.image));
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Image.asset(
                        post.image,
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
                          onPressed: null,
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0)),
                          icon: const FaIcon(
                            FontAwesomeIcons.heart,
                            color: Colors.black,
                          ),
                          label: Text(
                            post.numLike.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          )),
                      TextButton.icon(
                          onPressed: () => showModalBottomSheet(
                                enableDrag: true,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => ScreenSheetListComment(
                                  listComment: const [],
                                ),
                              ),
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0)),
                          icon: const FaIcon(
                            FontAwesomeIcons.comment,
                            color: Colors.black,
                          ),
                          label: const Text(
                            "0",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )),
                      TextButton.icon(
                          onPressed: null,
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0)),
                          icon: const FaIcon(
                            FontAwesomeIcons.bookmark,
                            color: Colors.black,
                          ),
                          label: Text(
                            post.numSave.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ))
                    ],
                  ),
                  const Divider(),
                  const Gap(15),

                  // ===============================
                  //================================
                  //========= Comment ==============
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            AssetImage("assets/images/avatar1.jpg"),
                      ),
                      const Gap(15),
                      Expanded(
                        child: TextFormField(
                          controller: controller.commentText,
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: "Text your comment in here...",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                          ),
                        ),
                      ),
                      // Visibility(
                      //   visible: false,
                      //   child: Expanded(
                      //     child: TextFormField(
                      //       controller: controller.postID,
                      //       //initialValue: post.id.toString(),
                      //     ),
                      //   ),
                      // ),
                      const Gap(15),
                      GestureDetector(
                          onTap: () {
                            controller.submitedComment(post.id);
                          },
                          child: const FaIcon(FontAwesomeIcons.arrowRight)),
                    ],
                  ),
                  const Gap(15),
                  const Text(
                    "Comments",
                    style: TextStyle(
                      fontWeight: MyFontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 400,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    decoration: const BoxDecoration(
                        // color: Color(0xfff2f2f2),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            //...listComment.map((e) => CommentItem(comment: e)),
                            ...controller
                                .getListCommentByID(post.id)
                                .map((e) => CommentItem(comment: e)),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
