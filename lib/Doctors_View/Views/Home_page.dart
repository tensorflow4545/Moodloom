import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:HappyLink/Doctors_View/Views/SessionInfo.dart';
import 'package:HappyLink/controller/FireBase_controller/CurrentUserController.dart';
import 'package:HappyLink/controller/Thoughts_controller.dart';
import 'package:HappyLink/utils/colors.dart';
import 'dart:math';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({Key? key}) : super(key: key);

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  final userController = Get.put(CurrentUserController());
  final thoughts = Get.put(ThoughtsController());
  final Random random = Random();
  int num = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    thoughts.postAllThpughts();
    userController.fetchCurrentDoctor();
    num = random.nextInt(16);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Obx(() {
              return Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "${userController.doctor.value.doctorDetails?.name}",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.textColor),
                ),
              );
            }),
          ),
          Text(
            "You have 4 appointments today",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Stack(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Thought of the day!!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orange.withOpacity(0.3),
                      ),
                      child: Obx(() {
                        return Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(right: 200),
                          child: Text(
                            "“${thoughts.AllThoughts.value.thoughts?[num].text ?? " "}”",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ),
              Positioned(
                right: 20,
                bottom: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width -
                      100, // Set a fixed width for the Container
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SvgPicture.asset('assets/PNGFiles/Group_5.svg'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Upcoming sessions",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => SessionInfo());
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20)),
                        height: 100,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.person),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Satyam Rana",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "20 Year old, depression",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                                Text(
                                  "02 sept 2023, 2:00pm",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
