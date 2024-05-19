import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myfontweight.dart';

class BioTab extends StatelessWidget {
  String bioText, joinTime;
  BioTab({super.key, required this.bioText, required this.joinTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropCapText(
            bioText,
            style: const TextStyle(
              fontWeight: MyFontWeight.medium,
              letterSpacing: 1,
              wordSpacing: 0.2,
              decorationThickness: 5,
            ),
            dropCapStyle: const TextStyle(
              fontSize: 28,
            ),
          ),
          const Gap(10),
          SizedBox(
            height: 30,
            child: ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(MyColor.bookMarkColor),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              ),
              child: const Text(
                "Edit",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Gap(10),
          Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.clock,
                size: 14,
              ),
              const Gap(10),
              Text("Joined at $joinTime")
            ],
          )
        ],
      ),
    );
  }
}
