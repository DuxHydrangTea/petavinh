import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/models/comment.dart';
import 'package:petavinh/views/components/detailpost_components/comment_item.dart';

// ignore: must_be_immutable
class ListComments extends StatelessWidget {
  List<Comment> listComment;
  ListComments({super.key, required this.listComment});

  @override
  Widget build(BuildContext context) {
    List<CommentItem> listCommentItem = <CommentItem>[];
    listComment.forEach(
      (element) {
        listCommentItem.add(CommentItem(comment: element));
      },
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Comments(${listComment.length})",
          style:
              const TextStyle(fontWeight: MyFontWeight.semiBold, fontSize: 17),
        ),
        const Divider(),
        SizedBox(
          width: double.infinity,
          height: 700,
          child: Scrollbar(
            child: ListView(
              children: [...listCommentItem],
            ),
          ),
        ),
      ],
    );
  }
}
