import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petavinh/config/base_url.dart';
import 'package:petavinh/config/loader_widget.dart';
import 'package:petavinh/config/my_snack_bar.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  late TextEditingController usernameTextEdit, passwordTextEdit;
  @override
  void onInit() {
    super.onInit();
    usernameTextEdit = TextEditingController();
    passwordTextEdit = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    usernameTextEdit.dispose();
    passwordTextEdit.dispose();
  }

  login() {
    if (usernameTextEdit.text.isEmpty || passwordTextEdit.text.isEmpty) {
      mySnackBar(
          "Text field is empty!", "Please fill full of TextFields !", false);
      return;
    } else {
      Get.showOverlay(
        asyncFunction: () => loginAction(),
        loadingWidget: const LoaderWidget(),
      );
    }
  }

  loginAction() async {
    var post =
        await http.post(Uri.parse("${BaseUrl.getBaseUrl()}login.php"), body: {
      'username': usernameTextEdit.text,
      'password': passwordTextEdit.text,
    });
    var res = await json.decode(post.body);
    if (res['success']) {
      mySnackBar("Login", "Success", true);
    } else {
      mySnackBar("Login", "False", false);
    }
  }
}
