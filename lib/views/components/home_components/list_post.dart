import 'package:flutter/cupertino.dart';
import 'package:petavinh/models/comment.dart';
import 'package:petavinh/models/post.dart';
import 'package:petavinh/views/components/home_components/post_group_item.dart';
import 'package:petavinh/views/components/home_components/post_item.dart';

// ignore: must_be_immutable
class ListPost extends StatelessWidget {
  List<Post> listPost;
  List<Comment> listComment = <Comment>[];
  ListPost({super.key, required this.listPost, required this.listComment});

  @override
  Widget build(BuildContext context) {
    List<Widget> listItem = <Widget>[];

    listPost.forEach(
      (element) {
        if (element.groupId == 0) {
          listItem.add(PostItem(
            post: element,
            listComment: [
              ...listComment.where((cmt) => cmt.postId == element.id)
            ],
          ));
        } else {
          listItem.add(PostGroupItem(
            post: element,
            listComment: [
              ...listComment.where((cmt) => cmt.postId == element.id)
            ],
          ));
        }
      },
    );
    print(listItem);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          ...listItem,
        ],
      ),
    );
  }
}
