import 'package:flutter/material.dart';
import 'package:HappyLink/User_View/views/common/snack_bar.dart';
import 'package:HappyLink/controller/Sessions_Controller.dart';

Container allSessions(
    BuildContext context, AllSessionsController sessiondata, int index) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF29B6F6).withOpacity(0.6)),
    width: MediaQuery.of(context).size.width - 60,
    padding: EdgeInsets.all(20),
    child: Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(
            "${sessiondata.AllSessions.value.session[index].doctorname}",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text("Msc in Clinical Psychology"),
        ),
        Divider(
          color: Colors.white,
          thickness: 0.5,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_month, color: Colors.grey),
                  Text("${sessiondata.AllSessions.value.session[index].date}")
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // showTimePicker(
                  //     context: context, initialTime: TimeOfDay.now());
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData(
                          primarySwatch: Colors.orange,
                          textTheme: TextTheme(
                            headline1: TextStyle(color: Colors.white),
                          ),
                          // accentColor: Colors.green,
                          buttonBarTheme: ButtonBarThemeData(
                            buttonMinWidth: 50.0,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  ).then((DateTime? selectedDate) {
                    if (selectedDate != null) {
                      print(selectedDate);
                      showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData(
                                primarySwatch: Colors.orange,
                                textTheme: TextTheme(
                                  headline1: TextStyle(color: Colors.white),
                                ),
                                // accentColor: Colors.green,
                                buttonBarTheme: ButtonBarThemeData(
                                  buttonMinWidth: 50.0,
                                ),
                              ),
                              child: child!,
                            );
                          }).then((TimeOfDay? selectedTime) {
                        if (selectedTime != null) {
                          print(selectedTime);
                        }
                      });
                    } else {
                      showSnackbar("select the date");
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "Book",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "View Profile",
                  style: TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
