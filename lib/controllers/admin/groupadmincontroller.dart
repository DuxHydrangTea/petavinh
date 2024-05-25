import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:petavinh/config/base_url.dart';
import 'package:petavinh/models/group.dart';
import 'package:petavinh/models/member.dart';
import 'package:petavinh/models/user.dart';

class GroupAdminController extends GetxController {
  late List<Group> listGroup;
  late List<Member> listMember;
  late List<User> listInfoMember;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listInfoMember = <User>[];
    listGroup = <Group>[];
    listMember = <Member>[];
    fetchListGroup();
    fetchMember();
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

  fetchListGroup() async {
    listGroup = <Group>[];
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}/admin/getallgroup.php"));
    var result = await json.decode(response.body);
    if (result['success']) {
      result['nhom'].forEach((g) {
        listGroup.add(
          Group(
            id: int.parse(g['id']),
            groupName: g['groupname'],
            groupImage: g['groupimage'],
            description: g['description'],
            rules: g['rules'],
            createdTime: g['created_time'],
          ),
        );
      });
    }
    update();
  }

  fetchMember() async {
    listMember = <Member>[];
    listInfoMember = <User>[];
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}/admin/getListMember.php"));
    var result = await json.decode(response.body);
    if (result['success']) {
      result['members'].forEach((m) {
        listMember.add(Member(
            id: int.parse(m['id']),
            userId: int.parse(m['user_id']),
            groupId: int.parse(m['group_id']),
            position: int.parse(m['postion']),
            approve: int.parse(m['approve'])));
        listInfoMember.add(User(
          id: int.parse(m['user_id']),
          username: m['username'],
          password: m['password'],
          fullname: m['fullname'],
          avatar: m['avatar'],
          joinedTime: m['joined_time'],
          description: m['description'],
          isAdmin: int.parse(m['isAdmin']),
        ));
      });
    }
    update();
  }

  List<User> getListMember(int groupId) {
    List<Member> lm = listMember
        .where(
            (element) => (element.groupId == groupId && element.approve == 1))
        .toList();

    List<User> us = <User>[];
    List<int> listIDMember = <int>[];

    // get list  ID user of List User in Group
    for (var element in lm) {
      listIDMember.add(element.userId);
    }

    // if USer in listUser has ID in list Member in Group
    for (var e in listIDMember) {
      User u = listInfoMember.firstWhere((element) => element.id == e);
      us.add(u);
    }
    return us;
  }

  bool isAdmin(int groupId, int userId) {
    for (var e in listMember) {
      if (e.groupId == groupId && e.userId == userId && e.position == 1) {
        return true;
      }
    }
    return false;
  }
}
