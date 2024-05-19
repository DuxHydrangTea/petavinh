import 'package:flutter/cupertino.dart';
import 'package:petavinh/models/comment.dart';
import 'package:petavinh/models/post.dart';

// ignore: must_be_immutable
class ListPost extends StatelessWidget {
  List<Post> listPost;
  List<Comment> listComment = <Comment>[];
  List<int> listLiked = <int>[];
  ListPost(
      {super.key,
      required this.listPost,
      required this.listComment,
      required this.listLiked});

  @override
  Widget build(BuildContext context) {
    List<Widget> listItem = <Widget>[];

    for (var element in listPost) {
      if (element.groupId == 0) {
        // listItem.add(PostItem(
        //   post: element,
        //   listComment: [
        //     ...listComment.where((cmt) => cmt.postId == element.id)
        //   ],
        //   isLike: listLiked.contains(element.id),
        // ));
      } else {
        // listItem.add(PostGroupItem(
        //   post: element,
        //   listComment: [
        //     ...listComment.where((cmt) => cmt.postId == element.id)
        //   ],
        //   isLike: listLiked.contains(element.id),

        //   onPressLike: () {},
        // ));
      }
    }

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
