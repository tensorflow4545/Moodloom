// controllers/user_controller.dart
import 'package:get/get.dart';
import 'package:HappyLink/Models/UserModels.dart';
import 'package:HappyLink/data/status.dart';
import 'package:HappyLink/repository/FireBase_Repo/UserRepo.dart';

class UserController extends GetxController {
  final UserRepo userRepository = UserRepo();
  RxList<User> users = <User>[].obs;
  final status = Status.LOADING.obs;

  fetchUsers() async {
    users.value = (await userRepository.getAllUsers());
  }

  void setStatus(Status value) {
    status.value = value;
  }

  void setAllUserModel(List<User> value) {
    users.value = value;
  }

  void postAllusers() {
    setStatus(Status.LOADING);
    userRepository.getAllUsers().then((value) {
      setStatus(Status.COMPLETED);
      if (value != []) {
        setAllUserModel(value);
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
