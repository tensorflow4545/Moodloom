import 'package:get/get.dart';
import 'package:HappyLink/Models/UserModels.dart';
import 'package:HappyLink/User_View/views/SplashScreen/firstSplashScreen.dart';
import 'package:HappyLink/data/status.dart';
import 'package:HappyLink/repository/user_repository.dart';
import 'package:HappyLink/User_View/views/SignupLogin/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final _api = LoginRepository();

  final userModel = UserModel().obs;
  final status = Status.LOADING.obs;

  void setStatus(Status value) {
    status.value = value;
  }

  void setUserModel(UserModel value) {
    userModel.value = value;
  }

  void postLogin() {
    setStatus(Status.LOADING);
    _api.getUserDetails().then((value) {
      setStatus(Status.COMPLETED);
      if (value != null) {
        setUserModel(value);
        print("User data received: ${userModel.value.user!.email}");
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

  void logout() async {
    await clearSharedPreferences();
    Get.offAll(Spscreen());
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
