import 'package:HappyLink/DataTest/TestModel.dart';
import 'package:HappyLink/User_View/views/Counsellor/Widgets/slots.dart';
import 'package:HappyLink/controller/FireBase_controller/CurrentUserController.dart';
import 'package:HappyLink/controller/FireBase_controller/Sessions_Controller.dart';
import 'package:HappyLink/data/status.dart';
import 'package:HappyLink/repository/FireBase_Repo/AllSessions.dart';
import 'package:HappyLink/utils/MonthWeek.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:HappyLink/controller/FireBase_controller/Counselors_controller.dart';
import 'package:HappyLink/utils/Theme_services.dart';
import 'package:table_calendar/table_calendar.dart';

class CounselorProfile extends StatefulWidget {
  final String name, email, imageUrl, language, position, cabin, id;
  CounselorProfile(
      {Key? key,
      required this.name,
      required this.id,
      required this.email,
      required this.language,
      required this.position,
      required this.cabin,
      required this.imageUrl})
      : super(key: key);

  @override
  State<CounselorProfile> createState() => _CounselorProfileState();
}

class _CounselorProfileState extends State<CounselorProfile> {
  final themeService = Get.find<ThemeService>();
  final sessionController = Get.put(SessionsController());
  final allcounselors = Get.find<AllCounselorController>();
  final userController = Get.find<CurrentUserController>();
  TextEditingController description = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime? today = DateTime.now();
  bool startAnimation = false;
  AllSessionsRepo sessionRepo = AllSessionsRepo();
  int n = 0;

  @override
  void initState() {
    super.initState();
    sessionController.fetchsessions();
    sessionController.fetcheachsessions(widget.id);
    sessionController.fetcheachDeletedsessions(widget.id);

    startAnimation = true;
  }

  void _reloadPage() {
    setState(() {
      sessionController.fetchsessions();
      sessionController.fetcheachsessions(widget.id);
      sessionController.fetcheachDeletedsessions(widget.id);
      startAnimation = true;
    });
  }

  void _onFormatChanged(CalendarFormat format) {
    setState(() {
      _calendarFormat = format;
      print(today!.weekday);
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      today = selectedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (sessionController.status.value) {
          case Status.LOADING:
            return Center(
                child: CircularProgressIndicator(
              strokeCap: StrokeCap.square,
              strokeWidth: 14,
              color: themeService.currentTheme.primaryColor,
            ));
          case Status.ERROR:
            Get.snackbar("Error", "Failed to load data");
            return Center(child: Text("Failed to load data"));
          case Status.COMPLETED:
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text("Profile"),
                  floating: true,
                  pinned: true,
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                          color: Colors.pink.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          CachedNetworkImage(
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            imageUrl: widget.imageUrl,
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color:
                                      themeService.currentTheme.scafholdColor,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(image: imageProvider),
                                ),
                              );
                            },
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleTags("Name: ", widget.name),
                              TitleTags("Email: ", widget.email),
                              TitleTags("position: ", widget.position),
                              TitleTags("Cabin no: ", widget.cabin),
                              TitleTags("Languages: ", widget.language),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                boxAdapter(),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (today!.weekday == 7) {
                        return Container(
                          child: Center(
                            child: Text("No Slots Available Today"),
                          ),
                        );
                      } else {
                        if (sessionController.allSessions[index].counselorId ==
                            widget.id) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: sessionController
                                .allSessions[index].allslots!.length,
                            itemBuilder: (context, i) {
                              bool isBooked = false;
                              bool isDeleted = false;
                              if (sessionController.eachSlot != []) {
                                for (int n = 0;
                                    n < sessionController.eachSlot.length;
                                    n++) {
                                  if (sessionController.eachSlot[n].fromDate ==
                                          "${today!.day} ${MonthWeek.months[today!.month]}" &&
                                      sessionController.eachSlot[n].startTime ==
                                          sessionController.allSessions[index]
                                              .allslots![i].startTime) {
                                    isBooked = true;
                                    break;
                                  }
                                }
                              }
                              if (sessionController.eachDeletedSlot != []) {
                                for (int n = 0;
                                    n <
                                        sessionController
                                            .eachDeletedSlot.length;
                                    n++) {
                                  if (sessionController
                                              .eachDeletedSlot[n].fromDate ==
                                          "${today!.day} ${MonthWeek.months[today!.month]}" &&
                                      sessionController
                                              .eachDeletedSlot[n].startTime ==
                                          sessionController.allSessions[index]
                                              .allslots![i].startTime) {
                                    isDeleted = true;
                                    break;
                                  }
                                }
                              }

                              Color containerColor = isBooked
                                  ? Colors.red.withOpacity(0.2)
                                  : (isDeleted)
                                      ? Colors.grey.withOpacity(0.3)
                                      : themeService
                                          .currentTheme.scafholdColor!;

                              return SlotsCard(
                                  index,
                                  containerColor,
                                  i,
                                  isBooked,
                                  isDeleted,
                                  context,
                                  "${sessionController.allSessions[index].allslots![i].startTime}",
                                  "${sessionController.allSessions[index].allslots![i].endTime}",
                                  today!,
                                  startAnimation,
                                  () => showMyCupertinoDialog(
                                      context,
                                      "${sessionController.allSessions[index].allslots![i].startTime}",
                                      "${sessionController.allSessions[index].allslots![i].endTime}"));
                            },
                          );
                        } else {
                          return Container();
                        }
                      }
                    },
                    childCount: sessionController.allSessions.length,
                  ),
                )
              ],
            );
        }
      }),
    );
  }

  SliverToBoxAdapter boxAdapter() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.topLeft,
            child: Text(
              "Available Sessions",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
            ),
          ),
          TableCalendar(
            focusedDay: today!,
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(Duration(days: 6)),
            availableCalendarFormats: {
              CalendarFormat.week: 'Week',
              CalendarFormat.month: 'Month',
            },
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(day, today),
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              tableBorder: TableBorder(
                verticalInside: BorderSide(
                  color: themeService.currentTheme.scafholdColor!,
                  width: 1.0,
                ),
              ),
            ),
            onDaySelected: _onDaySelected,
            onFormatChanged: _onFormatChanged, // Add this line
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: themeService.currentTheme.scafholdColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("available")
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red.withOpacity(0.2),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("booked")
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.grey.withOpacity(0.3),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("unavailable")
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  void showMyCupertinoDialog(
      BuildContext context, String startTime, String endTime) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Description'),
          content: Material(
            child: Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    controller: description,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                        hintText: "Description"),
                  ),
                )
              ],
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            CupertinoDialogAction(
              child: Text('Book'),
              onPressed: () {
                Allslots allslots = new Allslots(
                    description: description.text,
                    counselorId: widget.id,
                    patientId: userController.userId.value,
                    fromDate: "${today!.day} ${MonthWeek.months[today!.month]}",
                    isBooked: true,
                    isDeleted: true,
                    name: userController.userModel.value.userDetails!.name,
                    regdNo: "22BCE9015",
                    startTime: startTime,
                    endTime: endTime);
                sessionRepo.putSessions(allslots);
                _reloadPage();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
