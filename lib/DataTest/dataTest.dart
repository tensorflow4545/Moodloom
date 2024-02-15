import 'package:HappyLink/DataTest/TestModel.dart';
import 'package:HappyLink/Models/CommentModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataTest extends StatefulWidget {
  const DataTest({super.key});

  @override
  State<DataTest> createState() => _DataTestState();
}

class _DataTestState extends State<DataTest> {
  TextEditingController patientId = TextEditingController();
  TextEditingController fromTime = TextEditingController();
  TextEditingController toTime = TextEditingController();
  TextEditingController isBooked = TextEditingController();
  TextEditingController isDeleted = TextEditingController();

  putComment(WeeklyAppointment comments) async {
    // String firetoken = await getStoredCredentials("FireToken");
    try {
      await FirebaseFirestore.instance
          .collection('ScheduledSessions')
          .doc()
          .set(comments.toJson());
    } catch (e) {
      print('Error creating user data in Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: "patientId"),
            ),
            TextField(
              decoration: InputDecoration(hintText: "counselorId"),
            ),
            TextField(
              decoration: InputDecoration(hintText: "Date"),
            ),
            TextField(
              controller: fromTime,
              decoration: InputDecoration(hintText: "fromTime"),
            ),
            TextField(
              controller: toTime,
              decoration: InputDecoration(hintText: "toTime"),
            ),
            TextField(
              controller: isBooked,
              decoration: InputDecoration(hintText: "isbooked"),
            ),
            TextField(
              controller: isDeleted,
              decoration: InputDecoration(hintText: "isDeleted"),
            ),
            TextField(
              decoration: InputDecoration(hintText: "patientName"),
            ),
            InkWell(
              onTap: () {
                WeeklyAppointment newComment = new WeeklyAppointment(
                    counselorId: "65c643d9177511cc9fe1997d",
                    day: "Monday",
                    allslots: [
                      Allslots(startTime: "9:00 AM", endTime: "9:50 AM"),
                      Allslots(startTime: "10:00 AM", endTime: "10:50 AM"),
                      Allslots(startTime: "11:00 AM", endTime: "11:50 AM"),
                      Allslots(startTime: "12:00 PM", endTime: "12:50 PM"),
                      Allslots(startTime: "02:00 PM", endTime: "2:50 PM"),
                      Allslots(startTime: "3:00 PM", endTime: "3:50 PM"),
                      Allslots(startTime: "4:00 PM", endTime: "4:50 PM"),
                    ]);
                putComment(newComment);
              },
              child: Container(
                color: Colors.pink,
                height: 50,
                width: 100,
                child: Text("Push data"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
