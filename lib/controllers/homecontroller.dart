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
import 'package:petavinh/views/screen_login.dart';
// ignore: unused_import
import 'package:petavinh/views/screen_signup.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  String username = "";
  int id = 0;
  int selectedCategory = 0;
  int selectedLocal = 1;
  List<Topic> listTopic = [];
  List<Post> listRatestPost = <Post>[];
  List<Comment> listComment = <Comment>[];
  List<Post> listAllPost = <Post>[];
  List<Post> listPostExplore = <Post>[];
  List<Post> listPostFollow = <Post>[];
  @override
  void onInit() {
    super.onInit();
    isLogin();
    fetchListTopic();
    fetchComment();
    fecthListRatestPost();
    fecthListAllPost();
    fetchPostGroup();
    fetchPostByFollow();
  }

  isLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt('user_id') ?? 0;
    if (id == 0) {
      Get.to(ScreenLogin());
    } else {
      id = prefs.getInt('user_id')!;
      username = prefs.getString('username')!;
      update();
    }
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("user_id", 0);
    await prefs.setString("username", "");
    developer.log("${prefs.getInt('user_id')}");
    Get.to(ScreenLogin());
    update();
  }

  updateSelectCategory(int? index) {
    selectedCategory = index ?? 0;
    update();
  }

  updateSelectLocal(int? index) {
    selectedLocal = index ?? 0;
    update();
  }

  fetchPostGroup() async {
    listPostExplore = <Post>[];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('user_id') ?? 0;

    var response = await http.post(
        Uri.parse("${BaseUrl.getBaseUrl()}getLocalPostInGroup.php"),
        body: {'user_id': '$userId'});
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
      listPostExplore.add(Post(
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
    developer.log("${listPostExplore.length}");
    update();
  }

  fetchPostByFollow() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('user_id') ?? 0;

    var response = await http.post(
        Uri.parse("${BaseUrl.getBaseUrl()}getPostByMyFollowing.php"),
        body: {'user_id': '$userId'});
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
      listPostFollow.add(Post(
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
    developer.log("${listPostExplore.length}");
    update();
  }

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
    listPostExplore = <Post>[];
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
