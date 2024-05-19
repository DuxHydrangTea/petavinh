import 'package:flutter/material.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myfontweight.dart';

// ignore: must_be_immutable
class TabItem extends StatelessWidget {
  String label;
  bool isSelect;
  VoidCallback onPress;
  TabItem(
      {super.key,
      required this.label,
      this.isSelect = false,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: isSelect == true ? MyColor.mainColor : Colors.transparent,
      ),
      child: TextButton(
        onPressed: onPress,
        child: Text(
          label,
          style: TextStyle(
            color: isSelect == true ? Colors.white : const Color(0xff3f3f3f),
            fontSize: 14,
            fontWeight: MyFontWeight.semiBold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ));
  }
}
