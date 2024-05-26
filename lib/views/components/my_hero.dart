import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyHeroAlbum extends StatelessWidget {
  String tag;
  String description;
  MyHeroAlbum({super.key, required this.tag, this.description = ""});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Hero(
        tag: tag,
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.file(File(tag)),
                      Text(description),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
