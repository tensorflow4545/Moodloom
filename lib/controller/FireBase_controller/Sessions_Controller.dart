// controllers/user_controller.dart
import 'package:HappyLink/DataTest/TestModel.dart';
import 'package:HappyLink/Models/UserModels.dart';
import 'package:HappyLink/repository/FireBase_Repo/AllSessions.dart';
import 'package:get/get.dart';

import 'package:HappyLink/data/status.dart';

class SessionsController extends GetxController {
  final AllSessionsRepo sessionsRepository = AllSessionsRepo();
  final status = Status.LOADING.obs;
  RxList<WeeklyAppointment> allSessions = <WeeklyAppointment>[].obs;
  RxList<Allslots> eachDeletedSlot = <Allslots>[].obs;
  RxList<Allslots> eachSlot = <Allslots>[].obs;

  void setStatus(Status value) {
    status.value = value;
  }

  void setCurrentUserModel(List<WeeklyAppointment> value) {
    allSessions.value = value;
  }

  void seteachDeletedUserModel(List<Allslots> value) {
    eachDeletedSlot.value = value;
  }

  void seteachUserModel(List<Allslots> value) {
    eachSlot.value = value;
  }

  void fetchsessions() {
    setStatus(Status.LOADING);
    sessionsRepository.getAllSessions().then((value) {
      setStatus(Status.COMPLETED);
      if (value != []) {
        setCurrentUserModel(value);
      } else {
        setStatus(Status.ERROR);
        print("No user data available");
      }
      update(); // Trigger a rebuild
    }).catchError((error) {
      setStatus(Status.ERROR);
      print('Error: $error');
      update(); // Trigger a rebuild
    });
  }

  void fetcheachDeletedsessions(String id) async {
    setStatus(Status.LOADING);

    sessionsRepository.getEachDeletedSessions(id).then((value) {
      setStatus(Status.COMPLETED);
      if (value != null) {
        seteachDeletedUserModel(value);
      } else {
        setStatus(Status.ERROR);
        print("No user data available");
      }
      update(); // Trigger a rebuild
    }).catchError((error) {
      setStatus(Status.ERROR);
      print('Error: $error');
      update(); // Trigger a rebuild
    });
  }

  void fetcheachsessions(String id) async {
    setStatus(Status.LOADING);

    sessionsRepository.getEachCounselorSessions(id).then((value) {
      setStatus(Status.COMPLETED);
      if (value != null) {
        seteachUserModel(value);
      } else {
        setStatus(Status.ERROR);
        print("No user data available");
      }
      update(); // Trigger a rebuild
    }).catchError((error) {
      setStatus(Status.ERROR);
      print('Error: $error');
      update(); // Trigger a rebuild
    });
  }
}
