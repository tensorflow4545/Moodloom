import 'package:flutter/material.dart';
import 'dart:math';

import 'package:get/get.dart';
import 'package:HappyLink/controller/LoginSignup_controller.dart';
import 'package:HappyLink/utils/Theme_services.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final controller = Get.put(SignupLoginController());
  final themeService = Get.find<ThemeService>();
  final Random random = Random();
  int no = 0;
  bool isDone = false;
  List<List<String>> activities = [
    ["get some fresh air", "yoga for 20 mins", "Eat your fav. Food"],
    [
      "Take a nap for 30 mins",
      "Listen to your fav singer",
      "Talk to your friends/Parents"
    ],
    [
      "Spend some time in our community section",
      "Go get a walk",
      "Read a book"
    ],
    [
      "Take a break from your hectic schedule today",
      "Visit your nearest religious place",
      "Share any one of your problems with your parents/friends"
    ],
    [
      "Do your fav. Activity for 30 mins",
      "play some games",
      "Interact with your surrounding peoples"
    ]
  ];

  @override
  void initState() {
    super.initState();
    no = random.nextInt(activities.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeService.currentTheme.scafholdColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "My Activity",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: themeService.currentTheme.primaryColor),
              child: Text(
                "You have been Awesome 😇 today. Based on the Analysis Here's some tasks for you Today",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 120,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: (controller.isDone.value)
                  ? Text(
                      "Great, Good to go👍",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: activities[no].length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            activities[no][index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 28),
                          ),
                        );
                      },
                    ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 130,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.pink.withOpacity(0.4))),
                onPressed: () {
                  setState(() {
                    controller.isDone.value = true;
                    activities = [[]];
                  });
                },
                child: Container(
                  child: Row(
                    children: [Icon(Icons.done), Text("All done")],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
