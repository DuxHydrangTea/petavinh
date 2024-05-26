import 'package:petavinh/models/comment.dart';
import 'package:petavinh/models/post.dart';

class Sample {
  static Post post = Post(
      id: 1,
      title: "title",
      content: "content",
      userId: 1,
      fullname: "fullname",
      avatar: "assets/images/avatar1.jpg",
      topicId: 1,
      topicname: "topicname",
      groupId: 0,
      groupName: "groupName",
      groupImage: "groupImage",
      image: "assets/images/avatar1.jpg",
      postedDate: "2024-04-18 00:00:00",
      approve: 1,
      numLike: 11,
      numCmt: 12,
      numSave: 13);
  static Comment comment = Comment(
      id: 1,
      postId: 1,
      userId: 1,
      commentText: "commentText",
      commentedTime: "2024-04-18 00:00:00",
      fullname: "fullname",
      avatar: "assets/images/avatar1.jpg");
  static List<String> album = <String>[
    "assets/images/post3.jpg",
    "assets/images/post4.jpg",
    "assets/images/post5.jpg",
    "assets/images/post6.jpg",
    "assets/images/post7.png",
    "assets/images/post8.jpg",
    "assets/images/post9.jpg",
    "assets/images/post10.jpg",
  ];

  static String fileImage =
      "/data/user/0/com.example.petavinh/cache/511ce077-efd3-46c7-8606-46963fbd354f/FB_IMG_1714291713383.jpg";
}
