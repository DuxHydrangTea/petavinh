import 'package:flutter/material.dart';
import 'package:petavinh/models/topic.dart';

// ignore: must_be_immutable
class MyChip extends StatelessWidget {
  Topic topic;
  int? seleted;
  VoidCallback? onTap;
  MyChip({super.key, required this.topic, this.seleted = 0, this.onTap});

  @override
  Widget build(BuildContext context) {
    int index = topic.id ?? 0;
    Color bgrColor = seleted != index ? Colors.white : const Color(0xffff8a66);
    Color txtColor = seleted != index ? const Color(0xff524e4e) : Colors.white;
    Color borderColor = seleted != 0
        ? const Color.fromARGB(255, 186, 186, 186)
        : const Color(0xffff8a66);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        margin: const EdgeInsets.only(right: 10),
        child: ElevatedButton(
          onPressed: null,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(bgrColor),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                side: BorderSide(color: borderColor),
              ),
            ),
          ),
          child: Text(
            topic.topicname!,
            style: TextStyle(color: txtColor),
          ),
        ),
      ),
    );
  }
}
