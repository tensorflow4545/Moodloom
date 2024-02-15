import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import 'package:HappyLink/User_View/views/common/SideDrawer.dart';
import 'package:HappyLink/User_View/views/mentors/Mentors.dart';
import 'package:HappyLink/User_View/views/notifications/notification.dart';
import 'package:HappyLink/controller/FireBase_controller/CurrentUserController.dart';

import 'package:HappyLink/controller/Thoughts_controller.dart';
import 'package:HappyLink/utils/Theme_services.dart';

import 'package:HappyLink/utils/colors.dart';
import 'package:HappyLink/User_View/views/Sessions/All_users.dart';
import 'package:HappyLink/User_View/views/community/community.dart';
import 'package:HappyLink/User_View/views/HomePage/homepage.dart';
import 'package:HappyLink/User_View/views/settings/settings.dart';
import 'package:vibration/vibration.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;
  final controller = Get.put(CurrentUserController());
  final Thoughtscontroller = Get.put(ThoughtsController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final themeService = Get.find<ThemeService>();
  @override
  void initState() {
    super.initState();
    controller.fetchCurrentUser();
    Thoughtscontroller.postAllThpughts();
  }

  final List<Widget> _screens = [
    HomePage(),
    AllUsers(),
    Activity(),
    Community(),
    Settings()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Builder(
        // Wrap your body with Builder widget
        builder: (BuildContext context) {
          return _screens[_currentIndex];
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          currentIndex: _currentIndex,
          onTap: (index) {
            Vibration.vibrate(duration: 60);
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: themeService.currentTheme.primaryColor,
          showSelectedLabels: true,
          items: [
            BottomNavigationBarItem(
              backgroundColor: CustomColors.secondaryColor,
              icon: Icon(
                Icons.home,
                size: 30,
                color: (_currentIndex == 0)
                    ? themeService.currentTheme.primaryColor
                    : CustomColors.textColor,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group,
                  size: 30,
                  color: (_currentIndex == 1)
                      ? themeService.currentTheme.primaryColor
                      : CustomColors.textColor),
              label: 'Sessions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mobile_friendly,
                  size: 30,
                  color: (_currentIndex == 2)
                      ? themeService.currentTheme.primaryColor
                      : CustomColors.textColor),
              label: 'Activity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.comment,
                  size: 30,
                  color: (_currentIndex == 3)
                      ? themeService.currentTheme.primaryColor
                      : CustomColors.textColor),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 30,
                color: (_currentIndex == 4)
                    ? themeService.currentTheme.primaryColor
                    : CustomColors.textColor,
              ),
              label: 'Settings',
            ),
          ],
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold)),
      drawer: SideDrwaer(themeService.currentTheme.primaryColor!),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: themeService.currentTheme.scafholdColor,
      leading: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState?.openDrawer(); // Use context here
        },
        child: Container(
          margin: EdgeInsets.only(left: 20),
          alignment: Alignment.center,
          child: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Notifications(
              NoticeTitle: "notifications",
            );
          },
          child: badges.Badge(
            badgeContent: Text(
              "2",
              style: TextStyle(color: Colors.white),
            ),
            position: badges.BadgePosition.topEnd(top: 5, end: 25),
            child: IconButton(
              padding: EdgeInsets.only(right: 30),
              onPressed: () {},
              icon: Icon(
                Icons.notifications_outlined,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
