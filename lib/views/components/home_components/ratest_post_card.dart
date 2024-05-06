import 'package:flutter/cupertino.dart';
import 'package:petavinh/models/post.dart';
import 'package:petavinh/views/components/home_components/card_post.dart';

// ignore: must_be_immutable
class RatestPostCard extends StatelessWidget {
  List<Post> list;
  RatestPostCard({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    List<CardPost> listCardPost = <CardPost>[];
    list.forEach(
      (element) => listCardPost.add(CardPost(post: element)),
    );
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...listCardPost,
              // CardPost(
              //   post: Post(
              //       id: 1,
              //       title: 'title',
              //       content: 'content',
              //       userId: 1,
              //       fullname: 'fullname',
              //       avatar: 'assets/images/avatar1.jpg',
              //       topicId: 1,
              //       topicname: 'topic name',
              //       groupId: 0,
              //       groupName: '',
              //       groupImage: '',
              //       image: 'assets/images/avatar1.jpg',
              //       postedDate: '2024-04-20 00:00:00',
              //       approve: 1,
              //       numLike: 11,
              //       numCmt: 11,
              //       numSave: 11),
              // ),
              // CardPost(
              //   post: Post(
              //       id: 1,
              //       title: 'title',
              //       content: 'content',
              //       userId: 1,
              //       fullname: 'fullname',
              //       avatar: 'assets/images/avatar1.jpg',
              //       topicId: 1,
              //       topicname: 'topic name',
              //       groupId: 0,
              //       groupName: '',
              //       groupImage: '',
              //       image: 'assets/images/avatar1.jpg',
              //       postedDate: '2024-04-20 00:00:00',
              //       approve: 1,
              //       numLike: 11,
              //       numCmt: 11,
              //       numSave: 11),
              // ),
              // CardPost(
              //   post: Post(
              //       id: 1,
              //       title: 'title',
              //       content: 'content',
              //       userId: 1,
              //       fullname: 'fullname',
              //       avatar: 'assets/images/avatar1.jpg',
              //       topicId: 1,
              //       topicname: 'topic name',
              //       groupId: 0,
              //       groupName: '',
              //       groupImage: '',
              //       image: 'assets/images/avatar1.jpg',
              //       postedDate: '2024-04-20 00:00:00',
              //       approve: 1,
              //       numLike: 11,
              //       numCmt: 11,
              //       numSave: 11),
              // ),
            ],
          ),
        ));
  }
}
