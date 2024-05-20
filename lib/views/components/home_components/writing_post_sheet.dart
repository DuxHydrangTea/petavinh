import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:petavinh/config/myfontweight.dart';
import 'package:petavinh/views/components/container_border.dart';

class WritingPostSheet extends StatelessWidget {
  const WritingPostSheet({super.key});

  @override
  Widget build(BuildContext context) {
    int valueSampe = 1;
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ContainerBorder(
                          child: const CircleAvatar(
                            radius: 24,
                            backgroundImage:
                                AssetImage("assets/images/avatar1.jpg"),
                          ),
                        ),
                        const Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Phan Thi Thanh Ga`",
                              style: TextStyle(
                                fontWeight: MyFontWeight.semiBold,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    height: 30,
                                    width: 200,
                                    decoration: const BoxDecoration(
                                        color: Color(0xff9B7DEE),
                                        border: Border(),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        )),
                                    child: DropdownButton(
                                      iconEnabledColor: Colors.white,
                                      dropdownColor: const Color(0xff9B7DEE),
                                      underline: Container(),
                                      value: 2,
                                      hint: const Text("Choose any topic.."),
                                      onChanged: (int? valueN) {
                                        1;
                                      },
                                      items: const [
                                        DropdownMenuItem(
                                          value: 1,
                                          child: Text(
                                            "Y te 1",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 2,
                                          child: Text(
                                            "Y te 2",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 3,
                                          child: Text(
                                            "Y te 3",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    )),
                                const Gap(10),
                                const FaIcon(
                                  size: 30,
                                  FontAwesomeIcons.image,
                                  color: Colors.green,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    const Gap(10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            color: const Color(0xffD9D9D9),
                          )),
                      child: TextFormField(
                        maxLines: 20,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: "Text your content",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Gap(10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 40,
                      width: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: const Center(
                          child: Text(
                        "Post",
                        style: TextStyle(
                          fontWeight: MyFontWeight.semiBold,
                          color: Colors.white,
                        ),
                      )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
