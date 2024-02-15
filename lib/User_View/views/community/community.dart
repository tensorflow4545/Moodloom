import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:HappyLink/User_View/profilepage/profilepage.dart';
import 'package:HappyLink/User_View/views/common/Simmer_effect.dart';
import 'package:HappyLink/controller/FireBase_controller/AllComment.dart';
import 'package:HappyLink/controller/FireBase_controller/All_User_Controller.dart';

import 'package:HappyLink/User_View/views/community/widgets/Bottom_sheet.dart';
import 'package:HappyLink/controller/FireBase_controller/CurrentUserController.dart';
import 'package:HappyLink/data/status.dart';
import 'package:HappyLink/utils/Theme_services.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final themeService = Get.find<ThemeService>();
  // final controller = Get.put(CommentController());
  final FireCommentController = Get.put(AllCommentController());
  // final logincontroller = Get.find<LoginController>();
  // final AlluserController = Get.find<AllUserController>();
  final userController = Get.put(UserController());
  final currentUser = Get.find<CurrentUserController>();
  String currname = '';

  @override
  void initState() {
    super.initState();
    FireCommentController.getComments();
    // userController.
    userController.postAllusers();
  }

  final List tags = ["Trending", "Relationship", "SelfCare"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeService.currentTheme.scafholdColor,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Wellness Hub",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 30),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              children: [
                TextBar(tags[0], 0),
                TextBar(tags[1], 1),
                TextBar(tags[2], 2),
              ],
            ),
          ),
          CommentCard(tags[FireCommentController.category.value]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show the slide-up text field when the FAB is pressed

          setState(() {
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => SlideUpTextField(
                category: tags[FireCommentController.category.value],
              ),
              isScrollControlled:
                  true, // Set this to true for a full-height modal
            );
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF29B6F6).withOpacity(0.6),
      ),
    );
  }

  Expanded CommentCard(String category) {
    return Expanded(
      child: Obx(() {
        switch (userController.status.value) {
          case Status.LOADING:
            return ShimmerEffect();
          case Status.ERROR:
            Get.snackbar("Error", "Failed to load data");
            return SvgPicture.asset("assets/PNGFiles/page-not-found.svg");
          case Status.COMPLETED:
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: FireCommentController.allComments.length,
              itemBuilder: (context, index) {
                bool urs = false;
                if (FireCommentController.allComments[index].name ==
                    currentUser.userModel.value.userDetails?.name) {
                  urs = true;

                  currname = "${currentUser.userModel.value.userDetails?.name}";
                }
                if (FireCommentController.allComments[index].name ==
                    currentUser.doctor.value.doctorDetails?.name) {
                  urs = true;

                  currname = "${currentUser.doctor.value.doctorDetails?.name}";
                } else {
                  urs = false;
                }

                if (FireCommentController.allComments[index].category ==
                    category) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (urs)
                            ? Color.fromRGBO(140, 140, 216, 1).withOpacity(0.1)
                            : Colors.white),
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 15, bottom: 15),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              themeService.currentTheme.scafholdColor,
                          radius: 15,
                          child: Icon(
                            Icons.person,
                            size: 10,
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          child: Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    String userEmail = "";
                                    if (FireCommentController
                                            .allComments[index].name ==
                                        userController
                                            .users[index].userDetails!.name) {
                                      userEmail =
                                          "${userController.users[index].email}";
                                    }

                                    showCustomDialog(
                                        context,
                                        "${currname}",
                                        userEmail,
                                        "${currentUser.userModel.value.userDetails!.userId}",
                                        "${FireCommentController.allComments[index].userId}",
                                        "${FireCommentController.allComments[index].name}",
                                        urs);
                                  },
                                  child: Text(
                                    "${FireCommentController.allComments[index].name}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "${FireCommentController.allComments[index].message}",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/PNGFiles/ant-design-like-outlined.svg"),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SvgPicture.asset(
                                            "assets/PNGFiles/akar-icons-comment.svg"),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            );
        }
      }),
    );
  }

  Container TextBar(String text, int index) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      child: InkWell(
        onTap: () {
          setState(() {
            FireCommentController.setSelectedIndex(index);
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: FireCommentController.isSelected[index]
                ? themeService.currentTheme.primaryColor
                : Colors.grey.withOpacity(0.1),
          ),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Text(
            text,
            style: TextStyle(
              color: FireCommentController.isSelected[index]
                  ? Colors.white
                  : Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
