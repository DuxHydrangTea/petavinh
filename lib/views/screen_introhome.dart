import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:petavinh/config/myeffect.dart';
import 'package:petavinh/config/myfontweight.dart';
// ignore: unused_import
import 'package:petavinh/config/route.dart';
import 'package:petavinh/views/screen_home.dart';
import 'package:petavinh/views/screen_login.dart';
import 'package:petavinh/views/screen_signup.dart';

class ScreenIntroHome extends StatelessWidget {
  const ScreenIntroHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/Background.png"),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(child: Container()),
              Expanded(
                  flex: 2,
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Image.asset(
                            "assets/images/Logo-Ultra-Large.png",
                            height: 150,
                          )
                              .animate()
                              .rotate(
                                  delay: const Duration(milliseconds: 100),
                                  duration: const Duration(milliseconds: 500))
                              .fadeIn()
                              .scaleXY(),
                          ShaderMask(
                            shaderCallback: (bounds) =>
                                MyEffect.getLinearGradient2C(
                                        const Color(0xffFFFFFF),
                                        const Color(0xffE4A254))
                                    .createShader(bounds),
                            child: const Text("PetaVinh Social Network",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: MyFontWeight.bold,
                                )),
                          ),
                        ])),
                  )),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "PetaVinh Dev",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "myPoppins",
                            color: Colors.white),
                      ),
                      const Text(
                        "Mang xa hoi danh rieng cho thu cung, chung toi cam ket cho nguoi dung nhung giay phut mo mong nhat",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: null,
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              side: const BorderSide(color: Color(0xffFCA136)),
                            ),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => const ScreenSignUp());
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(color: Color(0xffFCA136)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "or",
                                style: TextStyle(color: Colors.white),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => ScreenLogin());
                                },
                                child: const Text(
                                  "Log in",
                                  style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          ShaderMask(
                            shaderCallback: (bounds) =>
                                MyEffect.getLinearGradient2C(
                                        const Color(0xffFFC581),
                                        const Color(0xffFCA136))
                                    .createShader(bounds),
                            child: TextButton(
                              onPressed: () {
                                Get.to(() => const ScreenHome());
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)))),
                              child: const Row(
                                children: [
                                  Text(
                                    "Explore",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      )),
    );
  }
}
