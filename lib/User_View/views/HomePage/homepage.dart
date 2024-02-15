import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:HappyLink/BMICalculator/Screens/input_page.dart';
import 'package:HappyLink/Doctors_View/Views/AllDoctors/all_doctors.dart';
import 'package:HappyLink/Models/UserModels.dart';
import 'package:HappyLink/User_View/views/Counsellor/Counsellor.dart';
import 'package:HappyLink/User_View/views/HomePage/components/Banners.dart';
import 'package:HappyLink/User_View/views/HomePage/components/IconList.dart';
import 'package:HappyLink/User_View/views/HomePage/components/IconsButtons.dart';
import 'package:HappyLink/User_View/views/call.dart';
import 'package:HappyLink/User_View/views/chatRoom/Chat_room.dart';
import 'package:HappyLink/User_View/views/website/website.dart';
import 'package:HappyLink/controller/All_Users_Controller.dart';
import 'package:HappyLink/controller/FireBase_controller/CurrentUserController.dart';
import 'package:HappyLink/controller/Thoughts_controller.dart';
import 'package:HappyLink/data/status.dart';
import 'package:HappyLink/utils/Theme_services.dart';

import 'package:HappyLink/utils/colors.dart';
import 'package:HappyLink/User_View/views/common/Simmer_effect.dart';
import 'package:HappyLink/utils/theme_controller.dart';
import 'package:HappyLink/utils/themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final themeService = Get.find<ThemeService>();
  final themeController = Get.find<ThemeController>();
  final usercontroller = Get.put(AllUsersController());
  // final LoginRepository repo = LoginRepository();
  // final logincontroller = Get.put(LoginController());
  final thoughtController = Get.find<ThoughtsController>();
  final Random random = Random();
  final userController = Get.find<CurrentUserController>();

  int no = 0;
  String name = '';

  @override
  void initState() {
    super.initState();
    userController.fetchCurrentUser();
    initializeData();
  }

  Future<void> initializeData() async {
    name = await getStoredCredentials('name');
    no = random.nextInt(16);
    thoughtController.postAllThpughts();
    // usercontroller.postAllusers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeService.currentTheme.scafholdColor,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20, top: 30),
            child: Text(
              "Welcome back,",
              style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                  color: CustomColors.textColor),
            ),
          ),
          Column(
            children: [
              Obx(() {
                return Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "${userController.userModel.value.userDetails?.name}",
                    style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.textColor),
                  ),
                );
              }),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, bottom: 20),
            child: Text(
              "How are you feeling today?😇",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: CustomColors.textColor),
            ),
          ),
          TodaysFeeling(),
          Obx(() {
            switch (thoughtController.status.value) {
              case Status.LOADING:
                return ThoughtSimmer();
              case Status.ERROR:
                Get.snackbar("Error", "Failed to load data");
                return Center(child: Text("Failed to load data"));
              case Status.COMPLETED:
                return Thoughts();
            }
          }),
          Padding(
            padding: EdgeInsets.only(left: 40, top: 20),
            child: Text(
              "Quick Links",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.textColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 20,
              children: [
                IconTags(
                  assets: Icons.chat,
                  function: () => Get.to(() => ChatRoom()),
                  label: "Chats",
                ),
                IconTags(
                  assets: Icons.boy_rounded,
                  function: () => Get.to(() => InputPage()),
                  label: "BMI",
                ),
                IconTags(
                  assets: Icons.web_asset,
                  function: () => Get.to(() => WebViewScreen(
                        url: "https://feynman034.netlify.app",
                      )),
                  label: "Website",
                ),
                IconTags(
                  assets: Icons.emergency_rounded,
                  function: () => Get.to(() => AllDoctors()),
                  label: "Emergency",
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40, top: 20),
            child: Text(
              "Today’s Task",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.textColor),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Banners(
            time: "4:30PM",
            heading: "1 on 1 Sessions",
            joinTag: "Book Now",
            bgcolor: Color(0xFFB0BEC5).withOpacity(0.7),
            asset: 'assets/PNGFiles/group-74.svg',
            funct: () => Get.to(() => MyCall(
                  callID: "ejhbadid",
                )),
          ),
          SizedBox(
            height: 30,
          ),
          Banners(
            time: "3:20PM",
            heading: "Peer Group Meetup",
            joinTag: "join now",
            bgcolor: Color(0xfffcddec),
            asset: 'assets/PNGFiles/Meetup_Icon.svg',
          ),
          SizedBox(
            height: 30,
          ),
          Banners(
            time: "Live now",
            heading: "Meditation",
            joinTag: "join now",
            bgcolor: Color(0x4cf09e54),
            asset: 'assets/PNGFiles/Meetup_Icon.svg',
            funct: () => Get.to(() => WebViewScreen(
                  url: "https://www.youtube.com/watch?v=ISITHR_UlBE",
                )),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeService.currentTheme.primaryColor,
        onPressed: () {},
        child: GestureDetector(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Counsellor())),
          child: Container(
            padding: EdgeInsets.all(2),
            alignment: Alignment.center,
            width: 70, // Adjust the width to make it bigger
            height: 70, // Adjust the height to make it bigger
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_3_sharp,
                  color: Colors.white,
                  size: 30, // Adjust the icon size
                ),
                SizedBox(height: 5), // Add some spacing between icon and text
                Text(
                  "Counsellor",
                  style: TextStyle(fontSize: 7, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container Banner(String heading, String joinTag, Color bgcolor, String asset,
      Function? funct) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 155,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: bgcolor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "06:00 PM",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => funct,
                      child: Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              joinTag,
                              style:
                                  TextStyle(color: Colors.pink, fontSize: 16),
                            ),
                            Icon(
                              Icons.play_circle,
                              color: Colors.pink,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SvgPicture.asset(asset)
            ],
          ),
        ],
      ),
    );
  }

  SingleChildScrollView TodaysFeeling() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          HorizontalIconList(
            asset: 'assets/PNGFiles/Happy.svg',
            label: 'Happy',
            color: Color.fromARGB(255, 226, 68, 150),
            funct: () {
              setState(() {
                themeController.changeTheme(HappyTheme());
              });
            },
          ),
          HorizontalIconList(
            asset: 'assets/PNGFiles/Focus.svg',
            label: 'Focus',
            color: Color.fromARGB(255, 108, 204, 201),
            funct: () {
              setState(() {
                themeController.changeTheme(FocusTheme());
              });
            },
          ),
          HorizontalIconList(
            asset: 'assets/PNGFiles/Calm.svg',
            label: 'Calm',
            color: Color.fromARGB(255, 139, 140, 236),
            funct: () {
              setState(() {
                themeController.changeTheme(CalmTheme());
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
              });
            },
          ),
        ],
      ),
    );
  }

  void funct() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyCall(
                  callID: "232asd",
                )));
  }

  Widget Thoughts() {
    return Container(
      height: 70,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: themeService.currentTheme.primaryColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
                "“${thoughtController.AllThoughts.value.thoughts?[no].text ?? " "}”",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                )),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  no = random.nextInt(16);
                });
              },
              icon: SvgPicture.asset("assets/PNGFiles/fa-quote-left.svg"))
        ],
      ),
    );
  }
}
