import 'package:flutter/material.dart';

import 'package:badges/badges.dart' as badges;

import 'package:HappyLink/User_View/views/notifications/notification.dart';

AppBar appBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: Container(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed: () {},
        child: Icon(
          Icons.menu,
          color: Colors.black,
        ),
      ),
    ),
    actions: [
      GestureDetector(
        onTap: () {
          Notifications(
            NoticeTitle: "notifications",
          );
        },
        child: badges.Badge(
          badgeContent: Text(
            "1",
            style: TextStyle(color: Colors.white),
          ),
          position: badges.BadgePosition.topEnd(top: 5, end: 25),
          child: IconButton(
            padding: EdgeInsets.only(right: 30),
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ],
  );
}
