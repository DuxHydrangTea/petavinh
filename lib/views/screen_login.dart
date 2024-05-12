import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/controllers/logincontroller.dart';
import 'package:petavinh/views/components/auth_components/mybutton.dart';
import 'package:petavinh/views/components/auth_components/mytextfield.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:petavinh/views/screen_signup.dart';
// ignore: depend_on_referenced_packages

class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: GetBuilder<LoginController>(builder: (controller) {
                    return Column(
                      children: [
                        // ignore: sized_box_for_whitespace
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Log in",
                                style: TextStyle(
                                    fontSize: 40, color: MyColor.textDarkColor),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Log in with your account",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: MyColor.textDarkColor,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              MyTextField(
                                textHint: "Username",
                                controller: controller.usernameTextEdit,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              MyTextField(
                                isPassword: controller.isShowPass,
                                textHint: "Password",
                                controller: controller.passwordTextEdit,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  controller.changeShowPass();
                                },
                                child: const Text("Show password"),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Checkbox(
                                  value: false,
                                  onChanged: null,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity(horizontal: -4),
                                ),
                                Text(
                                  "Remember?",
                                  style: TextStyle(color: MyColor.outlineColor),
                                ),
                              ],
                            ),
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
                          onPressed: () {
                            controller.login();
                          },
                          text: "Login",
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an accont?",
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const ScreenSignUp());
                                },
                                child: Text(
                                  "Sign up",
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
                          backgroundColor: MyColor.outlineColor,
                          icon: FontAwesomeIcons.google,
                          colorText: MyColor.textDarkColor,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyButton(
                          onPressed: null,
                          text: "Login with Apple",
                          backgroundColor: MyColor.outlineColor,
                          icon: FontAwesomeIcons.apple,
                          colorText: MyColor.textDarkColor,
                        )
                      ],
                    );
                  }),
                ),
              ],
            ),
          ))),
    );
  }
}
