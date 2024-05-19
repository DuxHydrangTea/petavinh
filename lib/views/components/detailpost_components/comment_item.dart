import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/models/comment.dart';
import 'package:petavinh/views/components/container_border.dart';

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
            // margin: const EdgeInsets.only(top: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContainerBorder(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(comment.avatar),
                  ),
                ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          comment.fullname,
                          style: const TextStyle(
                            fontWeight: MyFontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const Gap(10),
                        const FaIcon(
                          size: 13,
                          FontAwesomeIcons.clock,
                        ),
                        const Gap(5),
                        const Text("24h"),
                      ],
                    ),
                    SizedBox(
                      width: 299,
                      child: Text(comment.commentText),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
