import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:HappyLink/User_View/views/HomePage/components/IconList.dart';
import 'package:HappyLink/User_View/views/bottomNavigation/bottom_navigationbar.dart';
import 'package:HappyLink/utils/theme_controller.dart';
import 'package:HappyLink/utils/themes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "Let's Get Started!!",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
              ),
            ),
            SvgPicture.asset(
                "assets/PNGFiles/9454f2335f95840b63fdfe5e74166d9c.svg"),
            Container(
              child: Text(
                "How are you feeling today?",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(
              height: 90,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HorizontalIconList(
                  asset: 'assets/PNGFiles/Happy.svg',
                  label: 'Happy',
                  color: Color.fromARGB(255, 226, 68, 150),
                  funct: () {
                    themeController.changeTheme(HappyTheme());
                    Get.to(() => NavigationPage());
                  },
                ),
                HorizontalIconList(
                  asset: 'assets/PNGFiles/Focus.svg',
                  label: 'Focus',
                  color: Color.fromARGB(255, 108, 204, 201),
                  funct: () {
                    themeController.changeTheme(FocusTheme());
                    Get.to(() => NavigationPage());
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HorizontalIconList(
                  asset: 'assets/PNGFiles/Calm.svg',
                  label: 'Calm',
                  color: Color.fromARGB(255, 139, 140, 236),
                  funct: () {
                    setState(() {
                      themeController.changeTheme(CalmTheme());
                      Get.to(() => NavigationPage());
                    });
                  },
                ),
                HorizontalIconList(
                  asset: 'assets/PNGFiles/Relax.svg',
                  label: 'Relax',
                  color: Color.fromARGB(255, 238, 149, 72),
                  funct: () {
                    setState(() {
                      themeController.changeTheme(RelaxTheme());
                      Get.to(() => NavigationPage());
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
