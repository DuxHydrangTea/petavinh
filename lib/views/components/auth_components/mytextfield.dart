import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  bool isPassword;
  String textHint;
  TextEditingController? controller;
  MyTextField(
      {super.key,
      required this.textHint,
      this.controller,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xffB2B2B2))),
      child: TextFormField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
            hintText: textHint,
            border: InputBorder.none,
            hintStyle: const TextStyle(color: Color(0xffB2B2B2))),
      ),
    );
  }
}
