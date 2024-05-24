import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:petavinh/config/base_url.dart';
import 'package:petavinh/models/topic.dart';

class TopicAdminController extends GetxController {
  late List<Topic> listTopic;
  late TextEditingController txtAddTopicName;
  late TextEditingController txtAddDes;

  late TextEditingController txtEditTopicId;
  late TextEditingController txtEditTopicName;
  late TextEditingController txtEditTopicDes;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    txtAddTopicName = TextEditingController();
    txtAddDes = TextEditingController();
    txtEditTopicId = TextEditingController();
    txtEditTopicName = TextEditingController();
    txtEditTopicDes = TextEditingController();
    fetchListTopic();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    txtAddTopicName.dispose();
    txtAddDes.dispose();
    txtEditTopicDes.dispose();
    txtAddTopicName.dispose();
    txtEditTopicId.dispose();
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.closeDrawer();
  }

  fetchListTopic() async {
    listTopic = <Topic>[];
    var response =
        await http.post(Uri.parse("${BaseUrl.getBaseUrl()}getAllTopics.php"));
    var result = await json.decode(response.body);

    result['topic_list'].forEach((v) {
      int id = int.parse(v['id']);
      String topicname = v['topicname'];
      String des = v['description'];
      listTopic.add(Topic(id: id, topicname: topicname, description: des));
    });
    update();
  }

  addTopic() async {
    String topicName = txtAddTopicName.text;
    String des = txtAddDes.text;
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}/admin/addtopic.php"), body: {
      'topic_name': topicName,
      'description': des,
    });
    var result = await json.decode(response.body);
    if (result['success']) {
      txtAddTopicName.text = "";
      txtAddDes.text = "";
      fetchListTopic();
      Get.snackbar("Thông báo", result['message']);
    } else {
      Get.snackbar("Thông báo", result['message']);
    }
    update();
  }

  deleteTopic(int topicId) async {
    var response = await http.post(
        Uri.parse("${BaseUrl.getBaseUrl()}/admin/deletetopic.php"),
        body: {
          'topic_id': topicId.toString(),
        });
    var result = await json.decode(response.body);
    if (result['success']) {
      fetchListTopic();
      Get.snackbar("Thông báo", result['message']);
    } else {
      Get.snackbar("Thông báo", result['message']);
    }
    update();
  }

  editTopic() async {
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}/admin/edittopic.php"), body: {
      'topic_id': txtEditTopicId.text,
      'topic_name': txtEditTopicName.text,
      'description': txtEditTopicDes.text,
    });
    var result = await json.decode(response.body);
    if (result['success']) {
      fetchListTopic();
      Get.snackbar("Thông báo", result['message']);
    } else {
      Get.snackbar("Thông báo", result['message']);
    }
    update();
  }
}
