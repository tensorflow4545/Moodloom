// controllers/user_controller.dart
import 'package:HappyLink/User_View/views/SplashScreen/firstSplashScreen.dart';
import 'package:get/get.dart';
import 'package:HappyLink/Models/All_Doctors_Model.dart';
import 'package:HappyLink/Models/UserModels.dart';
import 'package:HappyLink/data/status.dart';
import 'package:HappyLink/repository/FireBase_Repo/UserRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUserController extends GetxController {
  final UserRepo userRepository = UserRepo();
  final status = Status.LOADING.obs;
  final userModel = User().obs;
  final doctor = Doctor().obs;
  final RxString userId = "".obs;

  void setStatus(Status value) {
    status.value = value;
  }

  void setCurrentUserModel(User value) {
    userModel.value = value;
  }

  void setCurrentDoctorModel(Doctor value) {
    doctor.value = value;
  }

  void fetchCurrentUser() {
    setStatus(Status.LOADING);
    userRepository.getCurrentUserInfo().then((value) {
      setStatus(Status.COMPLETED);
      if (value != null) {
        getUserId();
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

  void fetchCurrentDoctor() {
    setStatus(Status.LOADING);
    userRepository.getCurrentDoctorInfo().then((value) {
      setStatus(Status.COMPLETED);
      if (value != null) {
        setCurrentDoctorModel(value);
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

  void getUserId() async {
    userId.value = await getStoredCredentials('FireToken');
  }

  void logout() async {
    await clearSharedPreferences();
    Get.offAll(Spscreen());
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
