// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/views/components/auth_components/mybutton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petavinh/views/components/auth_components/mytextfield.dart';
import 'package:petavinh/views/screen_login.dart';
import 'package:get/get.dart';

class ScreenSignUp extends StatelessWidget {
  const ScreenSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            color: const Color(0xffE0D5C7),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Center(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/Logo-Ultra-Large.png",
                    height: 150,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: Column(
                      children: [
                        // ignore: sized_box_for_whitespace
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sign up",
                                style: TextStyle(
                                    fontSize: 40, color: MyColor.textDarkColor),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Create a new account",
                                style: TextStyle(
                                    fontSize: 15, color: MyColor.textDarkColor),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              MyTextField(textHint: "Username"),
                              const SizedBox(
                                height: 15,
                              ),
                              MyTextField(textHint: "Fulllname"),
                              const SizedBox(
                                height: 15,
                              ),
                              MyTextField(textHint: "Password"),
                              const SizedBox(
                                height: 15,
                              ),
                              MyTextField(textHint: "Repeat Password"),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Forgot the password",
                              style: TextStyle(color: MyColor.mainColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyButton(
                          onPressed: null,
                          text: "Sign up",
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Have an account?",
                                style: TextStyle(color: MyColor.textDarkColor),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => ScreenLogin());
                                },
                                child: Text(
                                  "Log in",
                                  style: TextStyle(
                                    color: MyColor.mainColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const Divider(),
                            Container(
                                padding: const EdgeInsets.all(2),
                                color: Colors.white,
                                child: Positioned(
                                    child: Text(
                                  "Or continue with",
                                  style: TextStyle(color: MyColor.outlineColor),
                                )))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyButton(
                          onPressed: null,
                          text: "Login with Google",
                          backgroundColor: MyColor.grayColor,
                          icon: FontAwesomeIcons.google,
                          colorText: MyColor.textDarkColor,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyButton(
                          onPressed: null,
                          text: "Login with Apple",
                          backgroundColor: MyColor.grayColor,
                          icon: FontAwesomeIcons.apple,
                          colorText: MyColor.textDarkColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ))),
      ),
    );
  }
}
