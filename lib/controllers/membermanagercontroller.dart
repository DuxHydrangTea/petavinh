import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:petavinh/config/base_url.dart';
import 'package:petavinh/models/member.dart';
import 'package:petavinh/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberController extends GetxController {
  int groupId;
  MemberController({required this.groupId});
  late List<Member> listMember;
  late List<User> listUser;
  int userId = 0;
  //
  //
  //

  //
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    fetchMember();
    fetchUser();

    updateUserId();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  updateUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id') ?? 0;
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
        if (int.parse(m['approve']) == 1) {
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

  bool isAdminGroup() {
    bool isAdmin = false;
    Member me = listMember.firstWhere(
        (element) => element.userId == userId && element.groupId == groupId,
        orElse: () =>
            Member(id: 0, userId: 0, groupId: 0, position: 0, approve: 0));
    if (me.position == 1) isAdmin = true;
    return isAdmin;
  }

  bool getAdminGroup(int idUser) {
    bool isAdmin = false;
    Member me = listMember.firstWhere(
        (element) => element.userId == idUser && element.groupId == groupId,
        orElse: () =>
            Member(id: 0, userId: 0, groupId: 0, position: 0, approve: 0));
    if (me.position == 1) isAdmin = true;
    return isAdmin;
  }

  denyUser(int userId) async {
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}denyUser.php"), body: {
      'user_id': '$userId',
      'group_id': '$groupId',
    });
    var result = json.decode(response.body);
    if (result['success']) {
      Get.snackbar("Thong bao", "Kick thanh cong");
      fetchMember();
      update();
    }
  }
}
