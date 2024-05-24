import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:petavinh/config/base_url.dart';
import 'package:petavinh/models/user.dart';

class UserAdminController extends GetxController {
  List<User> listUser = <User>[];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController txtAddUsername;
  late TextEditingController txtAddFullname;
  late TextEditingController txtAddPassword;
  late TextEditingController txtAddBio;
  late Rx<File> image;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listUser = <User>[];
    fetchAllUser();
    txtAddUsername = TextEditingController();
    txtAddFullname = TextEditingController();
    txtAddPassword = TextEditingController();
    txtAddBio = TextEditingController();
    image = File("").obs;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    txtAddUsername.dispose();
    txtAddFullname.dispose();
    txtAddPassword.dispose();
    txtAddBio.dispose();
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.closeDrawer();
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

  onDeleteUser(int userId) async {
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}/admin/deleteUser.php"), body: {
      'user_id': userId.toString(),
    });
    var result = await json.decode(response.body);
    if (result['success']) {
      fetchAllUser();
    } else {
      Get.snackbar("Delete Action", "Failed");
    }
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

  addUser() async {
    String usern, pass, fname, bio;
    usern = txtAddUsername.text;
    pass = txtAddPassword.text;
    fname = txtAddFullname.text;
    bio = txtAddBio.text;
    String avatar = image.value.path;
    if (avatar == "" || usern == "" || pass == "" || fname == "" || bio == "") {
      Get.snackbar("Error", "Please fill full of TextField");
    } else {
      var response = await http
          .post(Uri.parse("${BaseUrl.getBaseUrl()}/admin/addUser.php"), body: {
        'username': usern,
        'password': pass,
        'fullname': fname,
        'avatar': avatar,
        'bio': bio,
      });
      var result = await json.decode(response.body);
      if (result['success']) {
        Get.snackbar("Add user", "Add successfuly");
        fetchAllUser();
        // txtAddBio.text = "";
        // txtAddFullname.text = "";
        // txtAddPassword.text = "";
        // txtAddUsername.text = "";
        // image.value = File("");
      } else {
        Get.snackbar("Add user", "Invalid username !");
      }
    }
  }
}
