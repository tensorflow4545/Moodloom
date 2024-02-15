import 'package:flutter/material.dart';

import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';

import 'package:HappyLink/User_View/views/call.dart';
import 'package:HappyLink/User_View/views/common/Simmer_effect.dart';
import 'package:HappyLink/controller/BokkedAllSession_Controller.dart';
import 'package:HappyLink/data/status.dart';

class SwipeControllerWithDots extends StatefulWidget {
  @override
  _SwipeControllerWithDotsState createState() =>
      _SwipeControllerWithDotsState();
}

class _SwipeControllerWithDotsState extends State<SwipeControllerWithDots> {
  final controller = Get.put(BookedAllSessionController());
  int _currentPage = 4;

  @override
  void initState() {
    super.initState();
    controller.postAllusers();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.status.value) {
        case Status.LOADING:
          return ThoughtSimmer();
        case Status.ERROR:
          Get.snackbar("Error", "Failed to load data");
          return Center(child: Text("Failed to load data"));
        case Status.COMPLETED:
          return Column(
            children: [
              SizedBox(
                height: 300,
                width: 450,
                child: Swiper(
                  itemCount: controller
                      .allBookedSessions.value.allBookSessions!.length,
                  itemWidth: 400,
                  itemHeight: 350,
                  loop: true,
                  layout: SwiperLayout.STACK,
                  duration: 250,
                  scrollDirection: Axis.horizontal,
                  onIndexChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.topLeft,
                      height: 151,
                      width: MediaQuery.of(context).size.width - 30,
                      margin: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 224, 118, 173),
                          border: Border.all(width: 1, color: Colors.black)),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Upcoming Session",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "${controller.allBookedSessions.value.allBookSessions![index].doctorName}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Msc in Clinic Psycology",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "${controller.allBookedSessions.value.allBookSessions![index].date}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            width: 150,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => MyCall(
                                      callID: "232asd",
                                    ));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Join Now",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  Icon(
                                    Icons.play_circle,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              _buildDots(),
            ],
          );
      }
    });
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _currentPage,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          width: _currentPage == index ? 20.0 : 5.0,
          height: _currentPage == index ? 2.0 : 5.0,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: _currentPage == index ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }
}
