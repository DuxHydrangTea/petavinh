import 'package:flutter/material.dart';
import 'package:petavinh/models/comment.dart';
import 'package:petavinh/views/components/detailpost_components/comment_bar.dart';
import 'package:petavinh/views/components/detailpost_components/list_comments.dart';
// ignore: unused_import
import 'package:petavinh/views/components/home_components/post_item.dart';
// ignore: unused_import
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: unused_import
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class ScreenSheetListComment extends StatelessWidget {
  List<Comment> listComment;
  ScreenSheetListComment({super.key, required this.listComment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommentBar(),
              ListComments(
                listComment: listComment,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
