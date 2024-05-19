import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:petavinh/config/base_url.dart';
import 'package:petavinh/models/comment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostController extends GetxController {
  late TextEditingController commentText;
  List<Comment> listComment = <Comment>[];
  @override
  void onInit() {
    super.onInit();
    commentText = TextEditingController();
    fetchComment();
  }

  @override
  void onClose() {
    super.onClose();
    commentText.dispose();
  }

  submitedComment(int postid) async {
    String cmt = commentText.text;
    int id = postid;

    if (cmt.isNotEmpty) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      id = prefs.getInt('user_id') ?? 0;
      if (id != 0) {
        var post = await http
            .post(Uri.parse("${BaseUrl.getBaseUrl()}commentaction.php"), body: {
          'post_id': postid.toString(),
          'comment_text': cmt,
          'user_id': id.toString(),
        });
        var res = await json.decode(post.body);
        commentText.clear();
        Get.snackbar("Comment", "Comment Successfuly");
        var row = res['dataInserted'];
        Comment newComment = Comment(
            id: int.parse(row['id']),
            postId: int.parse(row['post_id']),
            userId: int.parse(row['user_id']),
            commentText: row['comment_text'],
            commentedTime: row['commented_time'],
            fullname: row['fullname'],
            avatar: row['avatar']);
        listComment.add(newComment);
        update();
      } else {
        Get.offAllNamed("/login");
      }
    }
  }

  fetchComment() async {
    var response =
        await http.post(Uri.parse("${BaseUrl.getBaseUrl()}getComment.php"));
    var result = await json.decode(response.body);
    result['binhluan_list'].forEach((v) {
      listComment.add(Comment(
        id: int.parse(v['id']),
        postId: int.parse(v['post_id']),
        userId: int.parse(v['user_id']),
        commentText: v['comment_text'],
        commentedTime: v['commented_time'],
        fullname: v['fullname'],
        avatar: v['avatar'],
      ));
    });
    update();
  }

  getListCommentByID(int postID) {
    List<Comment> list =
        listComment.where((element) => element.postId == postID).toList();
    list.sort((a, b) => b.id.compareTo(a.id));
    update();
    return list;
  }
}
