import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myfontweight.dart';

class BioTab extends StatelessWidget {
  const BioTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropCapText(
            "This is my Bio, i don't care any things who think, cause i very dep trai so i always true, you wrong. My mom is not fat, you fat. hehehe.",
            style: const TextStyle(
              fontWeight: MyFontWeight.normal,
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
          const Row(
            children: [
              FaIcon(
                FontAwesomeIcons.clock,
                size: 14,
              ),
              Gap(10),
              Text("Joined at 21 Jan 2024")
            ],
          )
        ],
      ),
    );
  }
}
