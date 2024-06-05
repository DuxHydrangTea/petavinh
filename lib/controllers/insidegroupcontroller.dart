import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:petavinh/config/base_url.dart';
import 'package:petavinh/models/comment.dart';
import 'package:petavinh/models/group.dart';
import 'package:petavinh/models/member.dart';
import 'package:petavinh/models/post.dart';
import 'package:petavinh/models/react.dart';
import 'package:petavinh/models/save.dart';
import 'package:petavinh/models/topic.dart';
import 'package:petavinh/models/user.dart';
import 'package:petavinh/views/screen_inside_group.dart';
import 'package:petavinh/views/screen_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsideGroupController extends GetxController {
  int groupId;
  late Group group;
  late List<Group> listGroup;
  late List<Member> listMember;
  late List<User> listMemberInfo;
  bool adminMode = false;
  //
  late List<Post> listPost;
  late List<User> listUser;
  late List<Topic> listTopic;

  // ID
  late List<int> listIdUser;
  late List<int> listIdTopic;
  // post
  late List<React> listReact;
  late List<Save> listSave;
  late List<Comment> listComment;
  //
  late RxList<User> listUserNotApprove;
  InsideGroupController({required this.groupId});
  // login
  late int idLogin;
  //
  var wIdTopic = 1.obs;
  Rx<File> image = File("").obs;
  late TextEditingController contentController;
  late TextEditingController titleController;
  //
  late User myUser;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    contentController = TextEditingController();
    titleController = TextEditingController();
    group = Group(
        id: 0,
        groupName: "groupName",
        groupImage:
            "/data/user/0/com.example.petavinh/cache/511ce077-efd3-46c7-8606-46963fbd354f/FB_IMG_1714291713383.jpg",
        description: "description",
        rules: "rules",
        createdTime: "createdTime");
    listGroup = <Group>[];
    listPost = <Post>[];
    listReact = <React>[];
    listSave = <Save>[];
    listComment = <Comment>[];
    fetchGroup();
    fetchMember();
    fetchListPost();
    fetchUser();
    fetchTopic();
    fetchListReact();
    fetchListSave();
    fetchComment();
    updateUser();
    getIdLogin();
    fetchUserNotApprove();
  }

  updateUser() async {
    int idLogin = 0;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    idLogin = prefs.getInt('user_id') ?? 0;
    myUser = User();
    var post = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}getUserByID.php"), body: {
      'user_id': idLogin.toString(),
    });
    var res = await json.decode(post.body);
    if (res['success']) {
      var user = res['user'];
      myUser = User(
        id: int.parse(user['id']),
        username: (user['username']),
        password: user['password'],
        fullname: user['fullname'],
        avatar: user['avatar'],
        joinedTime: user['joined_time'],
        description: user['description'],
        isAdmin: int.parse(user['isAdmin']),
      );
    }
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    contentController.dispose();
    titleController.dispose();
  }

  getIdLogin() async {
    idLogin = 0;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    idLogin = prefs.getInt('user_id') ?? 0;
    update();
  }

  fetchGroup() async {
    listGroup = <Group>[];
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}getgroupbyid.php"), body: {
      'group_id': groupId.toString(),
    });
    var result = await json.decode(response.body);
    if (result['success']) {
      var g = result['group'];
      group = Group(
        id: int.parse(g['id']),
        groupName: g['groupname'],
        groupImage: g['groupimage'],
        description: g['description'],
        rules: g['rules'],
        createdTime: g['created_time'],
      );
    }
    update();
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
        listMember.add(Member(
            id: int.parse(m['id']),
            userId: int.parse(m['user_id']),
            groupId: int.parse(m['group_id']),
            position: int.parse(m['postion']),
            approve: int.parse(m['approve'])));
      });
    }
    debugPrint(
        "list Mem: ${listMember.where((element) => element.approve == 1).length}");
    update();
  }

  int countMember() => listMember.length;

  fetchListPost() async {
    listPost = <Post>[];
    listIdTopic = <int>[];
    listIdUser = <int>[];
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
      listIdUser.add(userId);
      listIdTopic.add(topicId);
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
    });
    //debugPrint("u-t:  ${listIdUser.length} - ${listIdTopic.length}");
    for (var i in listIdUser) {
      debugPrint(" id user: $i");
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

  fetchUserNotApprove() async {
    listUserNotApprove = <User>[].obs;
    var response = await http.post(
        Uri.parse("${BaseUrl.getBaseUrl()}getAllUserNotApprove.php"),
        body: {
          'group_id': groupId.toString(),
        });
    //
    var result = await json.decode(response.body);
    if (result['success']) {
      result['user_not_approve'].forEach((user) {
        listUserNotApprove.value.add(User(
          id: int.parse(user['user_id']),
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

  fetchListReact() async {
    listReact = <React>[];
    var response =
        await http.post(Uri.parse("${BaseUrl.getBaseUrl()}getallreact.php"));
    var result = await json.decode(response.body);

    result['react_list'].forEach((v) {
      int id = int.parse(v['id']);
      int postId = int.parse(v['post_id']);
      int userId = int.parse(v['user_id']);
      String reactTime = v['react_time'];
      listReact.add(
          React(id: id, postId: postId, userId: userId, reactTime: reactTime));
    });
    update();
  }

  fetchListSave() async {
    listSave = <Save>[];
    var response =
        await http.post(Uri.parse("${BaseUrl.getBaseUrl()}getallsave.php"));
    var result = await json.decode(response.body);
    result['save_list'].forEach((v) {
      int id = int.parse(v['id']);
      int postId = int.parse(v['post_id']);
      int userId = int.parse(v['user_id']);
      listSave.add(Save(id: id, postId: postId, userId: userId));
    });

    update();
  }

  fetchComment() async {
    var response =
        await http.post(Uri.parse("${BaseUrl.getBaseUrl()}getComment.php"));
    var result = await json.decode(response.body);
    listComment = <Comment>[];
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

  User getUser(int userId) => listUser.firstWhere(
        (element) => element.id == userId,
        orElse: () => User(),
      );

  List<Post> getListApprove() =>
      listPost.where((element) => element.approve == 1).toList();

  List<Post> getListPostNotApprove() =>
      listPost.where((element) => element.approve == 0).toList();

// user not approve
  List<User> getListUserNotApprove() {
    List<Member> memberNotApprove =
        listMember.where((element) => element.approve == 0).toList();
    Set<int> listIdApprove = <int>{};
    for (var element in memberNotApprove) {
      listIdApprove.add(element.userId);
    }
    List<User> userNotApprove = <User>[];
    for (var el in listIdApprove) {
      userNotApprove
          .addAll(listUser.where((element) => element.id == el).toList());
    }
    return userNotApprove;
  }

  int countReact(int postId) =>
      listReact.where((element) => element.postId == postId).toList().length;

  int countComment(int postId) =>
      listComment.where((element) => element.postId == postId).toList().length;

  int countSave(int postId) =>
      listSave.where((element) => element.postId == postId).toList().length;

  bool isLiked(int postId) {
    List<int> listLiked = <int>[];
    for (var e in listReact) {
      if (e.postId == postId) {
        listLiked.add(e.userId);
      }
    }

    return listLiked.contains(idLogin);
  }

  bool isAdmin() {
    // List<Member> x = listMember
    //     .where(
    //         (element) => (element.userId == idLogin && element.position == 1))
    //     .toList();

    for (var m in listMember) {
      if (m.userId == idLogin && m.position == 1) {
        return true;
      }
    }
    return false;
  }

//
//

//
//
//

  bool isSaved(int postId) {
    List<int> listSaved = <int>[];
    for (var e in listSave) {
      if (e.postId == postId) {
        listSaved.add(e.userId);
      }
    }
    return listSaved.contains(idLogin);
  }

  saveAction(int postId) async {
    if (idLogin == 0) {
      Get.to(ScreenLogin());
    } else {
      // Khi người dùng đã đăng nhập
      // ignore: unused_local_variable
      var response = await http
          .post(Uri.parse("${BaseUrl.getBaseUrl()}saveaction.php"), body: {
        'user_id': '$idLogin',
        'post_id': '$postId',
      });

      fetchListSave();
      update();
    }
  }

  likeAction(int postId) async {
    if (idLogin == 0) {
      Get.to(ScreenLogin());
    } else {
      // Khi người dùng đã đăng nhập
      // ignore: unused_local_variable
      var response = await http
          .post(Uri.parse("${BaseUrl.getBaseUrl()}likeaction.php"), body: {
        'user_id': '$idLogin',
        'post_id': '$postId',
      });

      fetchListReact();
      update();
    }
  }

  outGroupAction() async {
    int groupId = group.id;
    int userId = idLogin;
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}outGroupAction.php"), body: {
      'user_id': '$userId',
      'group_id': '$groupId',
    });
    var result = await json.decode(response.body);
    if (result['success']) {
      Get.offAllNamed("/group");
    } else {
      Get.snackbar("Thong bao", "Out group failed");
    }
  }

  getListComment(int postId) {
    return listComment.where((element) => element.postId == postId).toList();
  }

  changeWriteIdTopic(int value) {
    wIdTopic.value = value;
    //update();
    //print(wIdTopic);
  }

  imagePicker(ImageSource imgS) async {
    try {
      final imagePick = await ImagePicker().pickImage(source: imgS);
      if (imagePick == null) {
        return;
      } else {
        image.value = File("");
        final imageTemp = File(imagePick.path);
        image.value = imageTemp;
        update();
      }
    } on PlatformException catch (e) {
      return e;
    }
  }

  onPost() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userID = prefs.getInt('user_id') ?? 0;
    String title = titleController.text;
    String content = contentController.text;
    int topicID = wIdTopic.value;
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}createGroupPost.php"), body: {
      'title': title,
      'content': content,
      'user_id': userID.toString(),
      'topic_id': topicID.toString(),
      'group_id': groupId.toString(),
      'image': image.value.path,
    });

    var result = await json.decode(response.body);
    if (result['success']) {
      Get.snackbar("Thông báo", "Đang chờ duyệt !");
      Get.to(ScreenInsideGroup(groupId: groupId));
    } else {
      Get.snackbar("Thông báo", "Đăng bài thất bại !");
    }
  }
}
