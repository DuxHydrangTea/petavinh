import 'package:get/get.dart';
import 'package:petavinh/views/screen_home.dart';
import 'package:petavinh/views/screen_introhome.dart';
import 'package:petavinh/views/screen_login.dart';
import 'package:petavinh/views/screen_profile.dart';
import 'package:petavinh/views/screen_signup.dart';

class MyRoute {
  // ignore: prefer_final_fields
  static String __home = "/",
      __introhome = "/introhome",
      __login = "/login",
      __signup = "/signup",
      __detail = "/detail",
      __profile = "/profile";
  static String getIntroHome() => __introhome;
  static String getHome() => __home;
  static String getLogin() => __login;
  static String getSignUp() => __signup;
  static String getDetail() => __detail;
  static String getProfile() => __profile;

  static List<GetPage> routes = [
    GetPage(
      name: __introhome,
      page: () => const ScreenIntroHome(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: __home,
      page: () => const ScreenHome(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: __login,
      page: () => ScreenLogin(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: __signup,
      page: () => const ScreenSignUp(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: __profile,
      page: () => const ScreenProfile(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1),
    ),
  ];
}
