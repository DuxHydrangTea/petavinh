import 'package:flutter/material.dart';
import 'package:petavinh/models/comment.dart';
import 'package:petavinh/models/post.dart';
import 'package:petavinh/views/components/home_components/post_item.dart';

// ignore: must_be_immutable
class PostTab extends StatelessWidget {
  List<Post> listPost;
  List<Comment> listComment;
  PostTab({super.key, required this.listPost, required this.listComment});

  @override
  Widget build(BuildContext context) {
    List<PostItem> listPostItems = <PostItem>[];
    for (var element in listPost) {
      listPostItems.add(PostItem(
        post: element,
        listComment: listComment.where((e) => e.postId == element.id).toList(),
        countReact: element.numLike,
        countSave: element.numSave,
        onPressLike: () {},
        onPressSave: () {},
      ));
    }
    return Column(
      children: [...listPostItems],
    );
  }
}
