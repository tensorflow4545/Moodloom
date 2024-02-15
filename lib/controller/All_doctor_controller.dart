import 'package:get/get.dart';
import 'package:HappyLink/Models/All_Doctors_Model.dart';
import 'package:HappyLink/data/status.dart';
import 'package:HappyLink/repository/All_Doctor_repository.dart';

class AllDoctorsController extends GetxController {
  final _api = AllDoctorsRepository();
  final AllDoctors = AllDoctorsModel().obs;
  final status = Status.LOADING.obs;

  void setStatus(Status value) {
    status.value = value;
  }

  void setAllUserModel(AllDoctorsModel value) {
    AllDoctors.value = value;
  }

  void postAllusers() {
    setStatus(Status.LOADING);
    _api.getAllDoctorDetails().then((value) {
      setStatus(Status.COMPLETED);
      if (value != null) {
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
