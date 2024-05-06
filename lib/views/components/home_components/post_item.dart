import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myeffect.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/models/comment.dart';
import 'package:petavinh/models/post.dart';
import 'package:petavinh/utils/mytime.dart';
import 'package:petavinh/views/sheet_list_comment.dart';

// ignore: must_be_immutable
class PostItem extends StatelessWidget {
  bool? isFollowed;
  Post post;
  List<Comment> listComment;
  PostItem(
      {super.key,
      this.isFollowed = false,
      required this.post,
      required this.listComment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: MyEffect.getBoxRadiusShadown(5, Colors.white),
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                        style: TextStyle(fontWeight: MyFontWeight.bold),
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
                      Gap(5),
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
                  backgroundColor: MaterialStatePropertyAll(Color(0xff9B7DEE)),
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
          Text(post.content),
          const Gap(5),
          // image
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: Hero(tag: "Haha", child: Image.asset(post.image)),
          ),
          // action
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                  onPressed: null,
                  style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                  icon: FaIcon(
                    FontAwesomeIcons.heart,
                    color: MyColor.heartColor,
                  ),
                  label: Text(
                    post.numLike.toString(),
                    style: TextStyle(
                      color: MyColor.heartColor,
                    ),
                  )),
              TextButton.icon(
                  onPressed: () => showModalBottomSheet(
                        enableDrag: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => ScreenSheetListComment(
                          listComment: listComment,
                        ),
                      ),
                  style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                  icon: FaIcon(
                    FontAwesomeIcons.comment,
                    color: MyColor.commentColor,
                  ),
                  label: Text(
                    listComment.length.toString(),
                    style: TextStyle(
                      color: MyColor.commentColor,
                    ),
                  )),
              TextButton.icon(
                  onPressed: null,
                  style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                  icon: FaIcon(
                    FontAwesomeIcons.bookmark,
                    color: MyColor.bookMarkColor,
                  ),
                  label: Text(
                    post.numSave.toString(),
                    style: TextStyle(
                      color: MyColor.bookMarkColor,
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
