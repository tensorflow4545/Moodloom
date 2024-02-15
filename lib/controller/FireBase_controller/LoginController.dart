import 'package:get/get.dart';
import 'package:HappyLink/User_View/views/bottomNavigation/bottom_navigationbar.dart';
import 'package:HappyLink/repository/FireBase_Repo/UserRepo.dart';

class LoginControllerFireBase extends GetxController {
  final userRepo = Get.put(UserRepo());
  static LoginControllerFireBase get instance => Get.find();

  Future<void> createUser(String email, String password) async {
    await userRepo.signWithEmailAndPassword(email, password);
  }
}
