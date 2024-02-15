import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:HappyLink/User_View/views/chatRoom/chat_page.dart';

void showCustomDialog(BuildContext context, String name, String email,
    String sourseID, String TargetId, String TargetName, bool self) {
  showDialog(
    barrierColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Material(
          elevation: 0,
          color: Colors.transparent,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 200,
              width: MediaQuery.of(context).size.width - 200,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 20,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            child: Icon(
                              Icons.cancel,
                              color: Colors.orange,
                              size: 35,
                            ),
                          ),
                        ),
                        (!self)
                            ? GestureDetector(
                                onTap: () {
                                  Get.to(() => ChatPage(
                                        targetId: TargetId,
                                        sourceId: sourseID,
                                        TargetName: TargetName,
                                      ));
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  child: Icon(
                                    Icons.chat,
                                    color: Colors.orange,
                                    size: 35,
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
