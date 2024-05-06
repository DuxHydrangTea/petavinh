import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petavinh/models/comment.dart';
import 'package:petavinh/utils/mytime.dart';

// ignore: must_be_immutable
class CommentItem extends StatelessWidget {
  Comment comment;
  CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(comment.avatar),
                ),
                const Gap(5),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              comment.fullname,
                              style: const TextStyle(
                                  fontWeight: MyFontWeight.semiBold),
                            ),
                            const Gap(10),
                            const FaIcon(
                              FontAwesomeIcons.solidClock,
                              size: 10,
                              color: Color(0xff414141),
                            ),
                            Text(
                              MyTime.diffTime(comment.commentedTime),
                              style: const TextStyle(
                                  fontSize: 11, color: Color(0xff414141)),
                            ),
                          ],
                        ),
                        Text(
                          comment.commentText,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
