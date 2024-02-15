import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:HappyLink/Doctors_View/Views/Home_page.dart';
import 'package:HappyLink/User_View/views/common/SideDrawer.dart';
import 'package:HappyLink/User_View/views/community/community.dart';
import 'package:HappyLink/User_View/views/settings/settings.dart';
import 'package:HappyLink/controller/FireBase_controller/CurrentUserController.dart';

import 'package:HappyLink/utils/colors.dart';

import 'package:HappyLink/User_View/views/common/app_bar.dart';

class DoctorNavigationPage extends StatefulWidget {
  const DoctorNavigationPage({super.key});

  @override
  State<DoctorNavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<DoctorNavigationPage> {
  final controller = Get.put(CurrentUserController());
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchCurrentDoctor();
  }

  final List<Widget> _screens = [
    DoctorHomePage(),
    SecondPage(),
    Community(),
    Settings()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.PrimaryColor,
      appBar: appBar(),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.orange,
        showSelectedLabels: true,
        items: [
          BottomNavigationBarItem(
            backgroundColor: CustomColors.secondaryColor,
            icon: Icon(
              Icons.home,
              color:
                  (_currentIndex == 0) ? Colors.orange : CustomColors.textColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group,
                color: (_currentIndex == 1)
                    ? Colors.orange
                    : CustomColors.textColor),
            label: 'MySession',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment,
                color: (_currentIndex == 2)
                    ? Colors.orange
                    : CustomColors.textColor),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color:
                  (_currentIndex == 3) ? Colors.orange : CustomColors.textColor,
            ),
            label: 'Settings',
          ),
        ],
      ),
      drawer: SideDrwaer(Colors.pink),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            "My Sessions",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class FourthPage extends StatelessWidget {
  const FourthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(
            "My Sessions",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
