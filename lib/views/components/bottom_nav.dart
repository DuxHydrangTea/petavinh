import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:petavinh/config/mycolor.dart';
import 'package:petavinh/views/screen_home.dart';
import 'package:petavinh/views/screen_profile.dart';

class MyBottomNav extends StatelessWidget {
  const MyBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> route = <Widget>[
      const ScreenHome(),
      const ScreenHome(),
      const ScreenHome(),
      const ScreenProfile(),
    ];
    int selected = 3;
    return SizedBox(
      height: 70,
      child: GNav(
        color: MyColor.mainColor,
        activeColor: MyColor.bookMarkColor,
        gap: 10,
        onTabChange: (index) {
          selected = index;
          Get.to(route[index]);
        },
        tabs: [
          GButton(
            icon: FontAwesomeIcons.house,
            text: "Home",
            active: selected == 0,
          ),
          const GButton(
            icon: FontAwesomeIcons.magnifyingGlass,
            text: "Search",
            active: true,
          ),
          const GButton(
            icon: FontAwesomeIcons.userGroup,
            text: "Group",
            active: true,
          ),
          GButton(
            icon: FontAwesomeIcons.solidUser,
            text: "Profile",
            active: selected == 3,
          )
        ],
      ),
    );
  }
}
