import 'dart:convert';

import 'package:get/get.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'package:petavinh/config/base_url.dart';
import 'package:petavinh/models/user.dart';

class UserAdminController extends GetxController {
  List<User> listUser = <User>[];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listUser = <User>[];
    fetchAllUser();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  fetchAllUser() async {
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
}
