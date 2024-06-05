import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:petavinh/config/base_url.dart';
import 'package:petavinh/models/member.dart';
import 'package:petavinh/models/post.dart';
import 'package:petavinh/models/topic.dart';
import 'package:petavinh/models/user.dart';

class GroupApproveController extends GetxController {
  int groupId;
  late List<Member> listMember;
  late List<User> listUser;
  late List<Post> listPost;
  late List<Topic> listTopic;
  GroupApproveController({required this.groupId});
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchMember();
    fetchUser();
    fetchListPost();
    fetchTopic();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  fetchMember() async {
    listMember = <Member>[];
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}getListMemberById.php"), body: {
      'group_id': groupId.toString(),
    });
    var result = await json.decode(response.body);
    if (result['success']) {
      result['members'].forEach((m) {
        if (int.parse(m['approve']) == 0) {
          listMember.add(Member(
              id: int.parse(m['id']),
              userId: int.parse(m['user_id']),
              groupId: int.parse(m['group_id']),
              position: int.parse(m['postion']),
              approve: int.parse(m['approve'])));
        }
      });
    }
    update();
  }

  fetchUser() async {
    listUser = <User>[];
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}admin/getalluser.php"));
    //
    var result = await json.decode(response.body);
    if (result['success']) {
      result['users'].forEach((user) {
        listUser.add(User(
          id: int.parse(user['id']),
          username: (user['username']),
          password: user['password'],
          fullname: user['fullname'],
          avatar: user['avatar'],
          joinedTime: user['joined_time'],
          description: user['description'],
          isAdmin: int.parse(user['isAdmin']),
        ));
      });
    }
    update();
  }

  User getUser(int userId) => listUser.firstWhere(
        (element) => element.id == userId,
        orElse: () => User(),
      );

  acceptUser(int userId) async {
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}acceptUser.php"), body: {
      'user_id': '$userId',
      'group_id': '$groupId',
    });
    var result = json.decode(response.body);
    if (result['success']) {
      Get.snackbar("Thong bao", "Accept thanh cong");
      fetchMember();
      update();
    }
  }

  denyUser(int userId) async {
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}denyUser.php"), body: {
      'user_id': '$userId',
      'group_id': '$groupId',
    });
    var result = json.decode(response.body);
    if (result['success']) {
      Get.snackbar("Thong bao", "Deny thanh cong");
      fetchMember();
      update();
    }
  }

  fetchTopic() async {
    listTopic = <Topic>[];
    var response =
        await http.post(Uri.parse("${BaseUrl.getBaseUrl()}getalltopics.php"));
    var result = await json.decode(response.body);

    result['topic_list'].forEach((v) {
      int id = int.parse(v['id']);
      String topicname = v['topicname'];
      String des = v['description'];
      listTopic.add(Topic(id: id, topicname: topicname, description: des));
    });
    update();
  }

  Topic getTopic(int topicId) {
    return listTopic.firstWhere(
      (element) => element.id == topicId,
      orElse: () => Topic(
        id: 0,
        topicname: "",
        description: "",
      ),
    );
  }

  fetchListPost() async {
    listPost = <Post>[];
    var response = await http.post(
        Uri.parse("${BaseUrl.getBaseUrl()}getAllPostByGroupID.php"),
        body: {
          'group_id': groupId.toString(),
        });
    var result = await json.decode(response.body);
    result['allpost'].forEach((v) {
      int id = int.parse(v['id']);
      String title = v['title'];
      String content = v['content'];
      int userId = int.parse(v['user_id']);
      int topicId = int.parse(v['topic_id']);
      int groupId = int.parse(v['group_id']);

      String image = v['image'];
      String postedDate = v['posted_date'];
      int approve = int.parse(v['approve']);
      if (int.parse(v['approve']) == 0) {
        listPost.add(Post(
          id: id,
          title: title,
          content: content,
          userId: userId,
          topicId: topicId,
          groupId: groupId,
          image: image,
          postedDate: postedDate,
          approve: approve,
        ));
      }
    });
  }

  acceptPost(int postId) async {
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}acceptPost.php"), body: {
      'post_id': '$postId',
    });
    var result = json.decode(response.body);
    if (result['success']) {
      Get.snackbar("Thong bao", "Accept thanh cong");
      onInit();
      update();
    }
  }

  denyPost(int postId) async {
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}denyPost.php"), body: {
      'post_id': '$postId',
    });
    var result = json.decode(response.body);
    if (result['success']) {
      Get.snackbar("Thong bao", "Deny thanh cong");
      fetchListPost();
      update();
    }
  }
}
