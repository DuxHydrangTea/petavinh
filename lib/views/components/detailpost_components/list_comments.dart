import 'package:flutter/material.dart';
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
    for (var element in listComment) {
      listCommentItem.add(CommentItem(comment: element));
    }
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Comments ( ${listComment.length} )",
            style:
                const TextStyle(fontWeight: MyFontWeight.medium, fontSize: 17),
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
      ),
    );
  }
}
