import 'package:get/get.dart';
import 'package:petavinh/views/admin/screen_admin_group.dart';
import 'package:petavinh/views/admin/screen_admin_post.dart';
import 'package:petavinh/views/admin/screen_admin_topic.dart';
import 'package:petavinh/views/admin/screen_admin_user.dart';
import 'package:petavinh/views/admin/select_client.dart';
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
      __profile = "/profile",
      __admin_client = "/admin/",
      __admin_user = "/admin/user/",
      __admin_post = "/admin/post/",
      __admin_topic = "/admin/topic/",
      __admin_group = "/admin/group/";

  static String getIntroHome() => __introhome;
  static String getHome() => __home;
  static String getLogin() => __login;
  static String getSignUp() => __signup;
  static String getDetail() => __detail;
  static String getProfile() => __profile;
  static String getAdminUser() => __admin_user;
  static String getAdminPost() => MyRoute.__admin_post;
  static String getAdminClient() => __admin_client;
  static String getAdminTopic() => __admin_topic;
  static String getAdminGroup() => __admin_group;
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
    GetPage(
      name: __admin_user,
      page: () => const ScreenAdminUser(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: __admin_post,
      page: () => const ScreenAdminPost(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: __admin_client,
      page: () => const ScreenAdminClient(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: __admin_topic,
      page: () => const ScreenAdminTopic(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: __admin_group,
      page: () => const ScreenAdminGroup(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1),
    )
  ];
}
