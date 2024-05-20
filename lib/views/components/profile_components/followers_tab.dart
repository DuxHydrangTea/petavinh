import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/models/user.dart';
import 'package:petavinh/views/components/container_border.dart';

// ignore: must_be_immutable
class FollowersTab extends StatelessWidget {
  List<User> listMeFollow;
  FollowersTab({super.key, required this.listMeFollow});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 750,
      child: Scrollbar(
        child: ListView.builder(
            itemCount: listMeFollow.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ContainerBorder(
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage(listMeFollow[index].avatar),
                          ),
                        ),
                        const Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listMeFollow[index].fullname,
                              style: const TextStyle(
                                fontWeight: MyFontWeight.semiBold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "@${listMeFollow[index].fullname}",
                              style: const TextStyle(
                                fontWeight: MyFontWeight.medium,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const Gap(10),
                        Text(
                          ".Follow",
                          style: TextStyle(
                            fontWeight: MyFontWeight.medium,
                            fontSize: 12,
                            color: MyColor.bookMarkColor,
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
                              "Remove",
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
