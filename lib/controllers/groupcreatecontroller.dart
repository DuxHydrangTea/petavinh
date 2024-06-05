import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:petavinh/config/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupCreateController extends GetxController {
  Rx<File> image = File("").obs;
  late TextEditingController nameController;
  late TextEditingController rulesController;
  late TextEditingController descriptionController;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nameController = TextEditingController();
    rulesController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    nameController.dispose();
    rulesController.dispose();
    descriptionController.dispose();
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

  createGroup() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userID = prefs.getInt('user_id') ?? 0;
    String name = nameController.text;
    String rules = rulesController.text;
    String des = descriptionController.text;
    String imagePath = image.value.path;
    var response = await http
        .post(Uri.parse("${BaseUrl.getBaseUrl()}createGroup.php"), body: {
      'name': name,
      'description': des,
      'rules': rules,
      'image': imagePath,
      'user_id': userID.toString(),
    });
    var result = await json.decode(response.body);
    if (result['success']) {
      Get.snackbar("Thong bao", result['message']);
    } else {
      Get.snackbar("Thong bao", result['message']);
    }
  }
}
