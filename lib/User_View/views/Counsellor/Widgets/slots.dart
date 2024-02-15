import 'package:HappyLink/utils/MonthWeek.dart';
import 'package:flutter/material.dart';

AnimatedContainer SlotsCard(
    int index,
    Color containerColor,
    int i,
    bool isBooked,
    bool isDeleted,
    BuildContext context,
    String startTime,
    String endTime,
    DateTime today,
    bool startAnimation,
    Function funct) {
  return AnimatedContainer(
    curve: Curves.easeInOut,
    duration: Duration(milliseconds: 500 + (index * 100)),
    transform: Matrix4.translationValues(0, startAnimation ? 0 : 500, 0),
    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: containerColor, // Use the determined color
    ),
    child: Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            "${today.day} ${MonthWeek.months[today.month]}",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(startTime),
            Text("------to-----"),
            Text(endTime),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                if (!isBooked && !isDeleted) {
                  funct.call();
                }
              },
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  (isBooked)
                      ? "Booked"
                      : (isDeleted)
                          ? "unavailable"
                          : "Book Now",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: (isBooked) ? Colors.grey : Colors.black),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Row TitleTags(String name, String desc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        alignment: Alignment.topLeft,
        child: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: Container(
          child: Text(
            desc,
          ),
        ),
      ),
    ],
  );
}
