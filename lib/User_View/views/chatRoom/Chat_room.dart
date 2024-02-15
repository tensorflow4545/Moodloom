import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:HappyLink/User_View/views/chatRoom/chat_page.dart';
import 'package:HappyLink/User_View/views/common/Simmer_effect.dart';
import 'package:HappyLink/User_View/views/website/website.dart';
import 'package:HappyLink/controller/FireBase_controller/All_User_Controller.dart';
import 'package:HappyLink/controller/FireBase_controller/CurrentUserController.dart';
import 'package:HappyLink/data/status.dart';
import 'package:HappyLink/utils/Theme_services.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final controller = Get.put(UserController());
  final CurrnetUser = Get.find<CurrentUserController>();
  final themeService = Get.find<ThemeService>();
  final Random random = Random();
  int no = 0;

  List<String> UserNames = [
    "Satyam Rana",
    "Anonymous012",
    "Anonymous032",
    "Anonymous056",
    "Anonymous096",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.postAllusers();
    no = random.nextInt(4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChatRoom"),
        backgroundColor: themeService.currentTheme.primaryColor,
        elevation: 0,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: themeService.currentTheme.scafholdColor,
        ),
        child: Obx(
          () {
            switch (controller.status.value) {
              case Status.LOADING:
                return CustomCardShimmer();
              case Status.ERROR:
                Get.snackbar("Error", "Failed to load data");
                return Center(child: Text("Failed to load data"));
              case Status.COMPLETED:
                return ListView.builder(
                    itemCount: controller.users.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (controller.users[index].userDetails!.userId !=
                          CurrnetUser.userModel.value.userDetails!.userId) {
                        return CustomCard(
                            image:
                                controller.users[index].userDetails!.imageurl,
                            name: controller.users[index].userDetails!.name,
                            currentMessage: "hello",
                            time: "12:30",
                            funct: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatPage(
                                            sourceId: CurrnetUser.userModel
                                                .value.userDetails!.userId,
                                            targetId: controller.users[index]
                                                .userDetails!.userId,
                                            TargetName: controller.users[index]
                                                .userDetails!.name!,
                                          )),
                                ));
                      }
                      return Container();
                    });
            }
          },
        ),
      ),
      floatingActionButton: IconButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.orange)),
          onPressed: () {
            Get.to(() => WebViewScreen(
                  url: "https://mind-mate-wellness.vercel.app/message",
                ));
          },
          icon: Icon(Icons.chat)),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Function()? funct;
  final String? image;
  final String? name;
  final String? currentMessage;
  final String? time;

  CustomCard({
    super.key,
    this.funct,
    this.name,
    this.currentMessage,
    this.time,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(140, 140, 216, 1).withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: funct,
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child:
              // Image.network(image!) != null
              //     ? Image.network(image!)
              //     :
              Icon(
            Icons.person,
            color: Colors.pink,
          ),
        ),
        title: Text(
          name!,
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        ),
        subtitle: Row(
          children: [
            Icon(
              Icons.done_all,
              size: 16,
            ),
            Text(
              currentMessage!,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            )
          ],
        ),
        trailing: Text(
          time!,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
