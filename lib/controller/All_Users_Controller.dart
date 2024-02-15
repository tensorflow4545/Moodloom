import 'package:get/get.dart';
import 'package:HappyLink/Models/All_users_model.dart';
import 'package:HappyLink/Models/UserModels.dart';
import 'package:HappyLink/data/status.dart';
import 'package:HappyLink/repository/All_user_repository.dart';

class AllUsersController extends GetxController {
  final _api = AllUsersRepository();
  final AllUsers = AllUsersModel().obs;
  final status = Status.LOADING.obs;
  late RxList<Data> filteredUsers = <Data>[].obs;
  late RxList<Data>? PrefData = <Data>[].obs;

  void localData() async {
    PrefData = (await loadDataLocally()).obs;
  }

  void setStatus(Status value) {
    status.value = value;
  }

  void setAllUserModel(AllUsersModel value) {
    AllUsers.value = value;
  }

  void postAllusers() {
    setStatus(Status.LOADING);
    _api.getAllUserDetails().then((value) {
      setStatus(Status.COMPLETED);
      if (value != null) {
        saveDataLocally(value.data!);
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

  void filterUsers(String query) {
    if (query.isEmpty) {
      // If the query is empty, show all users
      filteredUsers.assignAll(AllUsers.value.data!);
    } else {
      // Filter users based on the search query
      filteredUsers.assignAll(AllUsers.value.data!
          .where((user) =>
              user.userDetails!.name!
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              user.email!.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }
  }
}
