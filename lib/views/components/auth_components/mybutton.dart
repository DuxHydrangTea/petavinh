// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:petavinh/config/mycolor.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  VoidCallback? onPressed;
  String text;
  Color? backgroundColor;
  IconData? icon;
  Color? colorText;
  MyButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = const Color(0xffE5A454),
    this.icon,
    this.colorText = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)))),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null ? Icon(icon) : Container(),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(color: colorText),
            ),
          ],
        ),
      ),
    );
  }
}
