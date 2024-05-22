import 'package:flutter/cupertino.dart';
import 'package:petavinh/models/comment.dart';
import 'package:petavinh/models/post.dart';
import 'package:petavinh/views/components/home_components/card_post.dart';

// ignore: must_be_immutable
class RatestPostCard extends StatelessWidget {
  List<Post> list;
  List<Comment> listcmt;
  RatestPostCard({super.key, required this.list, required this.listcmt});

  @override
  Widget build(BuildContext context) {
    List<CardPost> listCardPost = <CardPost>[];
    for (var element in list) {
      listCardPost.add(CardPost(
        post: element,
      ));
    }
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...listCardPost,
            ],
          ),
        ));
  }
}
