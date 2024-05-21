import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:petavinh/config/base_url.dart';
import 'package:petavinh/models/post.dart';
import 'package:petavinh/models/user.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  int selectTab = 0;
  //
  //
  User userProfile = User();

  List<Map<String, String>> album = <Map<String, String>>[];
  List<Post> listMyPosts = <Post>[];
  List<User> listFollowed = <User>[];
  List<User> listUserMeFollow = <User>[];
  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
    fetchUserProfile();
    fetchUserAlbum();
    fetchMyPosts();
    fetchUserFollowMe();
    fetchUserMeFollow();
  }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
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
      //fullname = user['fullname'];
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

  fetchUserAlbum() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userID = prefs.getInt('user_id') ?? 0;
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}getalbum.php"), body: {
      'user_id': userID.toString(),
    });
    var result = await json.decode(response.body);
    var images = result['images'];
    images.forEach((e) {
      Map<String, String> newImage = <String, String>{};
      newImage['image'] = e['image'];
      newImage['content'] = e['content'];
      album.add(newImage);
    });
    // print(album);
    update();
  }

  fetchMyPosts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userID = prefs.getInt('user_id') ?? 0;
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}getMyPost.php"), body: {
      'user_id': userID.toString(),
    });
    var result = await json.decode(response.body);
    result['post'].forEach((v) {
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
      listMyPosts.add(Post(
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

  fetchUserFollowMe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userID = prefs.getInt('user_id') ?? 0;
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}getfollowertome.php"), body: {
      'user_id': userID.toString(),
    });
    var result = await json.decode(response.body);
    result['follower'].forEach((e) {
      listFollowed.add(User(
        id: int.parse(e['following_id']),
        username: e['username'],
        password: e['password'],
        fullname: e['fullname'],
        avatar: e['avatar'],
        joinedTime: e['joined_time'],
        description: e['description'],
        isAdmin: int.parse(e['isAdmin']),
      ));
    });
    update();
  }

  fetchUserMeFollow() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userID = prefs.getInt('user_id') ?? 0;
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}getusermefollow.php"), body: {
      'user_id': userID.toString(),
    });
    var result = await json.decode(response.body);
    if (result['success']) {
      result['follower'].forEach((e) {
        listUserMeFollow.add(User(
          id: int.parse(e['followed_id']),
          username: e['username'],
          password: e['password'],
          fullname: e['fullname'],
          avatar: e['avatar'],
          joinedTime: e['joined_time'],
          description: e['description'],
          isAdmin: int.parse(e['isAdmin']),
        ));
      });
    }

    update();
  }

  changeSelectTab(int id) {
    selectTab = id;
    update();
  }
}
