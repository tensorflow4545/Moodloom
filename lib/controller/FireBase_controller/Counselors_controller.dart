import 'package:get/get.dart';
import 'package:HappyLink/Models/FireBaseModels/Counselors_Model.dart';
import 'package:HappyLink/Models/UserModels.dart';
import 'package:HappyLink/data/status.dart';
import 'package:HappyLink/repository/FireBase_Repo/AllCounselors.dart';
import 'package:HappyLink/repository/FireBase_Repo/UserRepo.dart';

class AllCounselorController extends GetxController {
  final CounselorsRepo counselorRepo = CounselorsRepo();
  RxList<AllCounselors> counselors = <AllCounselors>[].obs;
  final status = Status.LOADING.obs;

  fetchUsers() async {
    counselors.value = (await counselorRepo.getComments());
  }

  void setStatus(Status value) {
    status.value = value;
  }

  void setAllUserModel(List<AllCounselors> value) {
    counselors.value = value;
  }

  void postAllusers() {
    setStatus(Status.LOADING);
    counselorRepo.getComments().then((value) {
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
