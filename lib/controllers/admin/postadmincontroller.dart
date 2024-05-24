import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:petavinh/config/base_url.dart';
import 'package:petavinh/models/group.dart';
import 'package:petavinh/models/post.dart';
import 'package:petavinh/models/topic.dart';
import 'package:petavinh/models/user.dart';

class PostAdminController extends GetxController {
  late List<Post> listAllPost;
  late List<Topic> listTopic;
  late List<User> listUser;
  late List<Group> listGroup;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listAllPost = <Post>[];
    listTopic = <Topic>[];
    listUser = <User>[];
    listGroup = <Group>[];
    fetchAllPost();
    fetchAllUser();
    fetchAllGroup();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.closeDrawer();
  }

  fetchAllGroup() async {
    listGroup = <Group>[];
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}/admin/getAllGroup.php"));
    var result = await json.decode(response.body);
    result['nhom'].forEach((g) {
      listGroup.add(Group(
          id: int.parse(g['id']),
          groupName: g['groupname'],
          groupImage: g['groupimage'],
          description: g['description'],
          rules: g['rules'],
          createdTime: g['created_time']));
    });
    update();
  }

  fetchAllPost() async {
    listAllPost = <Post>[];
    listTopic = <Topic>[];
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}/admin/getAllPost.php"));
    var result = await json.decode(response.body);
    if (result['success']) {
      result['allpost'].forEach((p) {
        listAllPost.add(Post(
            id: int.parse(p['id']),
            title: p['title'],
            content: p['content'],
            userId: int.parse(p['user_id']),
            topicId: int.parse(p['topic_id']),
            groupId: int.parse(p['group_id']),
            image: p['image'],
            postedDate: p['posted_date'],
            approve: int.parse(p['approve'])));
        listTopic.add(Topic(
          id: int.parse(p['topic_id']),
          topicname: p['topicname'],
        ));
      });
      print(listAllPost);
      print(listTopic);
      update();
    }
  }

  fetchAllUser() async {
    listUser = <User>[];
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}/admin/getalluser.php"));
    var result = await json.decode(response.body);
    if (result['success']) {
      result['users'].forEach((v) {
        listUser.add(User(
          id: int.parse(v["id"]),
          username: v['username'],
          password: v['password'],
          fullname: v['fullname'],
          avatar: v['avatar'],
          joinedTime: v['joined_time'],
          description: v['description'],
          isAdmin: int.parse(v['isAdmin']),
        ));
      });
    }
    update();
  }

  String getTopicNameByID(int id) =>
      listTopic.firstWhere((element) => element.id == id).topicname!;

  String getFullnameByID(int userId) =>
      listUser.firstWhere((element) => element.id == userId).fullname;

  String getAvatarByID(int userId) =>
      listUser.firstWhere((element) => element.id == userId).avatar;

  String getNameGroup(int groupId) =>
      listGroup.firstWhere((element) => element.id == groupId).groupName;

  String getImageGroup(int groupId) =>
      listGroup.firstWhere((element) => element.id == groupId).groupImage;

  deletePost(int postId) async {
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}/admin/deletepost.php"), body: {
      'post_id': postId.toString(),
    });
    var result = await json.decode(response.body);
    if (result['success']) {
      fetchAllPost();
      Get.snackbar("Thông báo", result['message']);
    } else {
      Get.snackbar("Thông báo", result['message']);
    }
    update();
  }
}
