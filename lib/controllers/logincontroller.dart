import 'dart:convert';

import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:petavinh/config/base_url.dart';
import 'package:petavinh/config/loader_widget.dart';
import 'package:petavinh/config/my_snack_bar.dart';
import 'package:petavinh/views/screen_home.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  late TextEditingController usernameTextEdit, passwordTextEdit;
  bool isShowPass = true;
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', 0);
    var post =
        await http.post(Uri.parse("${BaseUrl.getBaseUrl()}login.php"), body: {
      'username': usernameTextEdit.text,
      'password': passwordTextEdit.text,
    });
    var res = await json.decode(post.body);
    if (res['success']) {
      await prefs.setInt('user_id', int.parse(res['user']['id']));
      await prefs.setString('username', res['user']['username']);

      Get.offAll(() => const ScreenHome());
    } else {
      mySnackBar("Lỗi đăng nhập", "Sai tài khoản hoặc mật khẩu", false);
    }
  }

  changeShowPass() {
    isShowPass = !isShowPass;
    update();
  }
}
