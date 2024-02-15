import 'dart:ui';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Notifications extends StatelessWidget {
  String? NoticeTitle;
  String? Time;

  Notifications({
    super.key,
    this.NoticeTitle,
    this.Time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 393,
      height: 60,
      margin: EdgeInsets.only(bottom: 14, left: 17, right: 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Color(0x479d5b5f)),
      child: InkWell(
        onTap: () {
          showContainer(context, NoticeTitle ?? "");
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 10,
              ),
              alignment: Alignment.topLeft,
              child: Text(
                Time ?? "aa",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  NoticeTitle ?? "",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showContainer(BuildContext context, String Title) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          backgroundColor: Colors.transparent,
          // You can use any widget you want here
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.5)),
            width: 400,
            height: 500,
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "Important!!!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  Title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  child: Text("add description"),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
