// ignore: unused_import
import 'dart:convert';
import 'dart:io';

// ignore: unused_import
import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:mysql1/mysql1.dart';
// ignore: unused_import
import 'package:petavinh/config/base_url.dart';
// ignore: unused_import
import 'package:petavinh/config/loader_widget.dart';
// ignore: unused_import
import 'package:petavinh/config/my_snack_bar.dart';
import 'package:petavinh/models/comment.dart';
import 'package:petavinh/models/post.dart';
import 'package:petavinh/models/topic.dart';
// ignore: unused_import
import 'package:petavinh/views/screen_signup.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:mysql_client/mysql_client.dart';
import 'dart:developer' as developer;

class HomeController extends GetxController {
  int selectedCategory = 0;
  List<Topic> listTopic = [];
  List<Topic> listTopicSQL1 = <Topic>[];
  List<Post> listRatestPost = <Post>[];
  List<Comment> listComment = <Comment>[];
  List<Post> listAllPost = <Post>[];
  @override
  void onInit() {
    super.onInit();
    // fetchTopicSQLclient();
    fetchListTopic();
    fetchComment();
    fecthListRatestPost();
    fecthListAllPost();
  }

  updateSelectCategory(int? index) {
    selectedCategory = index ?? 0;
    update();
  }

  // Future<void> fetchTopicSQLclient() async {
  //   developer.log("message 111");
  //   var conn = await MySQLConnection.createConnection(
  //     host: "172.26.16.1",
  //     port: 3307,
  //     userName: "root",
  //     password: "123456",
  //     databaseName: "petavinh",
  //   );
  //   await conn.connect();
  //   var result = await conn.execute(
  //     "select * from topic",
  //   );
  //   developer.log(result.affectedRows.toString());
  //   for (final row in result.rows) {
  //     int tId = int.parse(row.colAt(0).toString());
  //     String tName = row.colAt(1).toString();
  //     String tDes = row.colAt(2).toString();
  //     Topic tp = Topic(id: tId, topicname: tName, description: tDes);
  //     listTopicSQL1.add(tp);
  //   }
  //   print(listTopicSQL1);
  //   update();
  // }

  fetchListTopic() async {
    listTopic = <Topic>[];
    String query = selectedCategory == 0
        ? "getAllTopics.php"
        : "getAllTopics.php?topicid=$selectedCategory";
    var response = await http.post(Uri.parse("${BaseUrl.getBaseUrl()}$query"));
    var result = await json.decode(response.body);

    result['topic_list'].forEach((v) {
      int id = int.parse(v['id']);
      String topicname = v['topicname'];
      String des = v['description'];
      listTopic.add(Topic(id: id, topicname: topicname, description: des));
    });
    update();
  }

  fecthListRatestPost() async {
    var response =
        await http.post(Uri.parse("${BaseUrl.getBaseUrl()}getPosts.php"));
    var result = await json.decode(response.body);
    result['allpost'].forEach((v) {
      int id = int.parse(v['id']);
      String title = v['title'];
      String content = v['content'];
      int userId = int.parse(v['user_id']);
      String fullname = v['fullname'];
      String avatar = v['avatar'];
      int topicId = int.parse(v['topic_id']);
      String topicname = v['topicname'];
      int groupId = int.parse(v['group_id']);
      String groupName = v['groupname'] ?? "";
      String groupImage = v['groupimage'] ?? "";

      String image = v['image'];
      String postedDate = v['posted_date'];
      int approve = int.parse(v['approve']);
      int numLike = int.parse(v['NUMLIKE']);
      int numCmt = int.parse(v['NUMCMT']);
      int numSave = int.parse(v['NUMSAVE']);
      listRatestPost.add(Post(
          id: id,
          title: title,
          content: content,
          userId: userId,
          fullname: fullname,
          avatar: avatar,
          topicId: topicId,
          topicname: topicname,
          groupId: groupId,
          groupName: groupName,
          groupImage: groupImage,
          image: image,
          postedDate: postedDate,
          approve: approve,
          numLike: numLike,
          numCmt: numCmt,
          numSave: numSave));
    });
    update();
  }

  fecthListAllPost() async {
    var response =
        await http.post(Uri.parse("${BaseUrl.getBaseUrl()}getAllPost.php"));
    var result = await json.decode(response.body);
    result['allpost'].forEach((v) {
      int id = int.parse(v['id']);
      String title = v['title'];
      String content = v['content'];
      int userId = int.parse(v['user_id']);
      String fullname = v['fullname'];
      String avatar = v['avatar'];
      int topicId = int.parse(v['topic_id']);
      String topicname = v['topicname'];
      int groupId = int.parse(v['group_id']);
      String groupName = v['groupname'] ?? "";
      String groupImage = v['groupimage'] ?? "";

      String image = v['image'];
      String postedDate = v['posted_date'];
      int approve = int.parse(v['approve']);
      int numLike = int.parse(v['NUMLIKE']);
      int numCmt = int.parse(v['NUMCMT']);
      int numSave = int.parse(v['NUMSAVE']);
      listAllPost.add(Post(
          id: id,
          title: title,
          content: content,
          userId: userId,
          fullname: fullname,
          avatar: avatar,
          topicId: topicId,
          topicname: topicname,
          groupId: groupId,
          groupName: groupName,
          groupImage: groupImage,
          image: image,
          postedDate: postedDate,
          approve: approve,
          numLike: numLike,
          numCmt: numCmt,
          numSave: numSave));
    });
    update();
  }

  fetchComment() async {
    var response =
        await http.post(Uri.parse("${BaseUrl.getBaseUrl()}getComment.php"));
    var result = await json.decode(response.body);
    result['binhluan_list'].forEach((v) {
      listComment.add(Comment(
        id: int.parse(v['id']),
        postId: int.parse(v['post_id']),
        userId: int.parse(v['user_id']),
        commentText: v['comment_text'],
        commentedTime: v['commented_time'],
        fullname: v['fullname'],
        avatar: v['avatar'],
      ));
    });
    update();
  }
}
