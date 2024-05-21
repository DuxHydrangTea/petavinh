// ignore: unused_import
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
// ignore: unused_import
import 'package:petavinh/config/base_url.dart';
// ignore: unused_import
import 'package:petavinh/config/loader_widget.dart';
// ignore: unused_import
import 'package:petavinh/config/my_snack_bar.dart';
import 'package:petavinh/models/comment.dart';
import 'package:petavinh/models/post.dart';
import 'package:petavinh/models/react.dart';
import 'package:petavinh/models/save.dart';
import 'package:petavinh/models/topic.dart';
import 'package:petavinh/models/user.dart';
import 'package:petavinh/views/screen_login.dart';
// ignore: unused_import
import 'package:petavinh/views/screen_signup.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  // Lưu trữ username
  String username = "";
  //Lưu trữ id người dùng
  int id = 0;
  // Thể loại bài viết đã chọn  - Ratest bar: -1 nghĩa là chọn hết
  int selectedCategory = -1;

  // Phạm vi bài viết đã chọn - Tất cả - chỉ trong group - chỉ những người mình follow
  int selectedLocal = 1;

  // Danh sách chủ đề
  List<Topic> listTopic = [];

  // Danh sách bài viết tốt nhất
  List<Post> listRatestPost = <Post>[];
  // Danh sách tổng hợp bình luận
  List<Comment> listComment = <Comment>[];
//
//
  // Danh sách tổng hợp bài viết
  List<Post> listAllPost = <Post>[];
  // Danh sách bài viết với local = Group
  List<Post> listPostExplore = <Post>[];
  // Danh sách bài viết với local = Follow
  List<Post> listPostFollow = <Post>[];
  // Danh sách chứa 1 trong 3 local
  List<Post> listByLocal = <Post>[];

  // Danh sách tổng hợp chứa các id bài viết mà người dùng đã LIKE
  List<int> listLiked = <int>[];
  // Danh sách tổng hợp các React
  List<React> listReact = <React>[];
//
//
//
  // Danh sách tổng hợp chứa id bài viết người đăng nhập đã SAVE
  List<int> listSavedByUserID = <int>[];
  // Danh sách tổng hợp các Save
  List<Save> listSave = <Save>[];
  User userProfile = User();
//
//
//
//
//      WRITE POST
  var wIdTopic = 1.obs;
  Rx<File> image = File("").obs;
  late TextEditingController contentController;
  late TextEditingController titleController;
//
//
//
//
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void onInit() {
    super.onInit();
    // check Đăng nhập
    isLogin();

    // Duyệt chủ đề
    fetchListTopic();
    // Duyệt danh sách tổng hợp bình luận
    fetchComment();
    // Duỵet danh sách bài viết tốt nhất
    fecthListRatestPost();
//
    // Duyệt tất cả bài viết
    fecthListAllPost();
    // Duyệt tất cả bài viết nhóm
    fetchPostGroup();
    // Duyệt tất cả bài viết từ người mình follow
    fetchPostByFollow();
//
    // Duyệt danh sách tổng hợp id bài viết mà người dùng đã like
    fetchListLiked();
    //fetchPostLocal();

    // Duyệt danh sách React, dựa vào post_id của list React có thể biết 1 bài viết có bao nhiêu Like
    fetchListReact();
//

    fetchListSave();
    fectListSavedByUser();
    fetchUserProfile();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    titleController.dispose();
    contentController.dispose();
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.closeDrawer();
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
    //developer.log("${prefs.getInt('user_id')}");
    Get.to(() => ScreenLogin());
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
    if (result['success']) {
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
    }
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
    String query = selectedCategory == -1
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

  fetchListLiked() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt('user_id') ?? 0;
    if (id == 0) {
      Get.to(ScreenLogin());
    } else {
      var response = await http.post(
          Uri.parse("${BaseUrl.getBaseUrl()}getPostLiked.php"),
          body: {'user_id': '$id'});
      var result = await json.decode(response.body);
      if (result['success']) {
        result['result'].forEach((item) {
          listLiked.add(int.parse(item['post_id']));
        });
      }
      //print(listLiked.length);
      update();
    }
  }

  fetchListReact() async {
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

  getCountReact(int postId) {
    int count = listReact.where((element) => element.postId == postId).length;
    update();
    return count;
  }

  updateCountReact() {}

  getPostLocal() {
    List<Post> list = <Post>[];
    // All
    if (selectedLocal == 1) {
      list = <Post>[];
      list = [...listAllPost];
      update();
    }
    // Group
    else if (selectedLocal == 2) {
      list = <Post>[];
      list = [...listPostExplore];
      update();
    }
    // Followed
    else {
      list = <Post>[];
      list = [...listPostFollow];
      update();
    }
    update();
    return list;
  }

  getListCommentByID(int postId) {
    List<Comment> cmtByIdPost = <Comment>[];
    for (var element in listComment) {
      if (element.postId == postId) {
        cmtByIdPost.add(element);
      }
    }
    update();
    return cmtByIdPost;
  }

// Thực hiện Like bài viết
  likeAction(int postId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt('user_id') ?? 0;
    if (id == 0) {
      Get.to(ScreenLogin());
    } else {
      // Khi người dùng đã đăng nhập
      var response = await http
          .post(Uri.parse("${BaseUrl.getBaseUrl()}likeaction.php"), body: {
        'user_id': '$id',
        'post_id': '$postId',
      });
      update();
      var result = await json.decode(response.body);
      // Hoạt động huỷ like
      if (result['state'] == 'unlike') {
        // Loại bỏ postId ra khỏi danh sách bài viết đã like (cập nhật màu heart)
        listLiked.remove(postId);

        // Loại bỏ React ra khỏi danh sách tổng hợp React (  )
        for (var e in listReact) {
          if (e.postId == postId) {
            listReact.remove(e);
          }
        }

        update();
      } else {
        var dataInserted = result['dataInserted'];
        listLiked.add(postId);
        listReact.add(React(
            id: int.parse(dataInserted['id']),
            postId: int.parse(dataInserted['post_id']),
            userId: int.parse(dataInserted['user_id']),
            reactTime: dataInserted['react_time']));

        update();
      }
      update();
    }
  }
//
//
//
//

// save action
  fetchListSave() async {
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

  fectListSavedByUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('user_id') ?? 0;
    //
    //
    //
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}getpostsaved.php"), body: {
      'user_id': userId.toString(),
    });
    var result = await json.decode(response.body);
    result['result'].forEach((v) {
      //int id = int.parse(v['id']);
      int postId = int.parse(v['post_id']);
      //int userId = int.parse(v['user_id']);
      listSavedByUserID.add(postId);
    });

    update();
  }

  getCountSave(int postId) {
    int count = listSave.where((element) => element.postId == postId).length;
    update();
    return count;
  }

  saveAction(int postId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt('user_id') ?? 0;
    if (id == 0) {
      Get.to(ScreenLogin());
    } else {
      // Khi người dùng đã đăng nhập
      var response = await http
          .post(Uri.parse("${BaseUrl.getBaseUrl()}saveaction.php"), body: {
        'user_id': '$id',
        'post_id': '$postId',
      });
      update();
      var result = await json.decode(response.body);
      // Hoạt động huỷ like
      if (result['state'] == 'unsave') {
        // Loại bỏ postId ra khỏi danh sách bài viết đã like (cập nhật màu heart)
        listSavedByUserID.remove(postId);

        // Loại bỏ React ra khỏi danh sách tổng hợp React (  )
        for (var e in listSave) {
          if (e.postId == postId) {
            listSave.remove(e);
          }
        }

        update();
      } else {
        var dataInserted = result['dataInserted'];
        listSavedByUserID.add(postId);
        listSave.add(Save(
          id: int.parse(dataInserted['id']),
          postId: int.parse(dataInserted['post_id']),
          userId: int.parse(dataInserted['user_id']),
        ));

        update();
      }
      update();
    }
  }

  fetchUserProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userID = prefs.getInt('user_id') ?? 0;
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}getuserbyid.php"), body: {
      'user_id': userID.toString(),
    });
    //
    var result = await json.decode(response.body);
    if (result['success']) {
      var user = result['user'];
      userProfile = User(
        id: int.parse(user['id']),
        username: (user['username']),
        password: user['password'],
        fullname: user['fullname'],
        avatar: user['avatar'],
        joinedTime: user['joined_time'],
        description: user['description'],
        isAdmin: int.parse(user['isAdmin']),
      );
      update();
    }
    update();
  }

//
//
//
//
//      WRITE POST ACTION
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
        .post(Uri.parse("${BaseUrl.getBaseUrl()}createPublicPost.php"), body: {
      'title': title,
      'content': content,
      'user_id': userID.toString(),
      'topic_id': topicID.toString(),
      'image': image.value.path,
    });

    var result = await json.decode(response.body);
    if (result['success']) {
      Get.snackbar("Thông báo", "Đăng bài thành công !");
      Get.offAllNamed("/");
    } else {
      Get.snackbar("Thông báo", "Đăng bài thất bại !");
    }
  }
}
