import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/config/myfontweight.dart';

class ScreenAdminPost extends StatelessWidget {
  const ScreenAdminPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  //border: Border.all(),
                  ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const FaIcon(FontAwesomeIcons.bars),
                      const Spacer(),
                      const Image(
                          height: 40,
                          image:
                              AssetImage("assets/images/Logo-Ultra-Large.png")),
                      const Gap(10),
                      Text(
                        "Dasboard",
                        style: TextStyle(
                          color: MyColor.mainColor,
                          fontSize: 20,
                          fontWeight: MyFontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const CircleAvatar(
                        radius: 15,
                        backgroundImage:
                            AssetImage("assets/images/avatar1.jpg"),
                      )
                    ],
                  ),
                  const Gap(20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffefefef),
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Post table",
                              style: TextStyle(
                                fontWeight: MyFontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Text("See all"),
                          ],
                        ),
                        const Gap(10),
                        //// listttttt user ////
                        SizedBox(
                          height: 700,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                //height: 200,
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: index.isEven
                                      ? const Color(0xffefefef)
                                      : Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text((index + 1).toString()),
                                    const Gap(10),
                                    Stack(
                                      children: [
                                        const ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          child: Image(
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                "assets/images/avatar1.jpg"),
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Align(
                                            alignment:
                                                const Alignment(1.5, 1.5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                              ),
                                              child: const CircleAvatar(
                                                radius: 10,
                                                backgroundImage: AssetImage(
                                                    "assets/images/post1.jpg"),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const Gap(10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: const BoxDecoration(
                                                color: Colors.purple,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: const Text(
                                              "Category",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 230,
                                          child: Text(
                                            "Yeah my cat would definitely just curl up on top of it",
                                            style: TextStyle(
                                                fontWeight:
                                                    MyFontWeight.semiBold),
                                          ),
                                        ),
                                        const Text("Ngoc Dung"),
                                      ],
                                    ),
                                    const Spacer(),
                                    FaIcon(
                                      FontAwesomeIcons.squareXmark,
                                      color: MyColor.heartColor,
                                    )
                                  ],
                                ),
                              );
                            },
                            itemCount: 30,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
