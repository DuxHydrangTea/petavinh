import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:petavinh/config/myfontweight.dart';

class FollowedTab extends StatelessWidget {
  const FollowedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 750,
      child: Scrollbar(
        child: ListView.builder(
            itemCount: 100,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 17,
                          backgroundImage:
                              AssetImage("assets/images/avatar1.jpg"),
                        ),
                        const Gap(10),
                        const Text(
                          "Nguyen Ngoc Dung",
                          style: TextStyle(
                            fontWeight: MyFontWeight.semiBold,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 30,
                          child: OutlinedButton(
                            onPressed: null,
                            style: OutlinedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                side:
                                    const BorderSide(color: Color(0xff3f3f3f))),
                            child: const Text(
                              "Unfollow",
                              style: TextStyle(
                                color: Color(0xff3f3f3f),
                                fontWeight: MyFontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
