import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:petavinh/config/base_url.dart';
import 'package:petavinh/models/group.dart';
import 'package:petavinh/models/member.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupController extends GetxController {
  late List<Group> listGroup;
  late List<Member> listMember;
  late List<Group> listGroupNotJoind;
  late int userId;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userId = 0;
    listGroup = <Group>[];
    // listMember = <Member>[];
    listGroupNotJoind = <Group>[];
    setUserId();
    fetchMember();
    fetchListGroup();
    fetchListGroupNotJoind();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  setUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id') ?? 0;
    update();
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
      });
    }
    //debugPrint("list Mem: ${listMember.length}");
    update();
  }

  fetchListGroupNotJoind() async {
    print(userId);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('user_id') ?? 0;

    listGroupNotJoind = <Group>[];

    // list userid - groupid da tham gia
    List<Member> listJoined =
        listMember.where((element) => element.userId == id).toList();

    for (var element in listGroup) {
      for (var joined in listJoined) {
        if (element.id != joined.groupId) {
          listGroupNotJoind.add(element);
        }
      }
    }
    update();
  }

  getListGrNotJoined() {
    int id = userId;
    listGroupNotJoind = <Group>[];

    List<Group> lj = <Group>[];
    // list userid - groupid da tham gia
    List<Member> listJoined =
        listMember.where((element) => element.userId == id).toList();

    // set IdGroup joined !
    Set<int> listIdGroupJoined = <int>{};
    for (var element in listJoined) {
      listIdGroupJoined.add(element.groupId);
    }
    for (var element in listGroup) {
      if (!listIdGroupJoined.contains(element.id)) {
        lj.add(element);
      }
    }
    return lj;
  }

  getListGrJoined() {
    int id = userId;
    listGroupNotJoind = <Group>[];

    List<Group> lj = <Group>[];
    // list userid - groupid da tham gia
    List<Member> listJoined = listMember
        .where((element) => (element.userId == id && element.approve == 1))
        .toList();

    // set IdGroup joined !
    Set<int> listIdGroupJoined = <int>{};
    for (var element in listJoined) {
      listIdGroupJoined.add(element.groupId);
    }
    for (var element in listGroup) {
      if (listIdGroupJoined.contains(element.id)) {
        lj.add(element);
      }
    }
    return lj;
  }

  getManageGroup() {
    int id = userId;
    listGroupNotJoind = <Group>[];

    List<Group> lj = <Group>[];
    // list userid - groupid da tham gia
    List<Member> listJoined = listMember
        .where((element) => (element.userId == id && element.position == 1))
        .toList();

    // set IdGroup joined !
    Set<int> listIdGroupJoined = <int>{};
    for (var element in listJoined) {
      listIdGroupJoined.add(element.groupId);
    }
    for (var element in listGroup) {
      if (listIdGroupJoined.contains(element.id)) {
        lj.add(element);
      }
    }
    return lj;
  }

  countMember(int groupId) {
    int c = listMember
        .where(
            (element) => (element.groupId == groupId && element.approve == 1))
        .toList()
        .length;
    return c;
  }
}
