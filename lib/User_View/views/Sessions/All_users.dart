import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:HappyLink/User_View/views/Sessions/swipCard.dart';
import 'package:HappyLink/controller/All_Users_Controller.dart';
import 'package:HappyLink/controller/Sessions_Controller.dart';
import 'package:HappyLink/data/status.dart';
import 'package:HappyLink/User_View/views/Sessions/widgets/All_sessions.dart';
import 'package:HappyLink/User_View/views/common/Simmer_effect.dart';
import 'package:HappyLink/utils/Theme_services.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  // final AllUsersController controller = AllUsersController();
  final themeService = Get.find<ThemeService>();

  TextEditingController searchController = TextEditingController();
  // final Sessioncontroller = Get.put(AllSessionsController());

  @override
  void initState() {
    super.initState();
    // Sessioncontroller.getAllSessions();
    // controller.postAllusers(); // Corrected method name
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeService.currentTheme.scafholdColor,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              "Search",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (query) {
                      setState(() {
                        // controller.filterUsers(query);
                      });
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SwipeControllerWithDots(),
          Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              "All Sessions",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
          ),
          // Expanded(
          //   child: Obx(() {
          //     switch (Sessioncontroller.status.value) {
          //       case Status.LOADING:
          //         return GroupSimmerEffect();
          //       case Status.ERROR:
          //         return Center(child: Text("Failed to load data"));
          //       case Status.COMPLETED:
          //         return ListView.builder(
          //           physics: BouncingScrollPhysics(),
          //           itemCount:
          //               Sessioncontroller.AllSessions.value.session.length,
          //           itemBuilder: (context, index) {
          //             return allSessions(context, Sessioncontroller, index);
          //           },
          //         );
          //     }
          //   }),
          // ),
        ],
      ),
    );
  }
}
