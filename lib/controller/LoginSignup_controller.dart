import 'package:get/get.dart';
import 'package:HappyLink/Models/SignUp.dart';
import 'package:HappyLink/data/status.dart';
import 'package:HappyLink/repository/Signup_repository.dart';

class SignupLoginController extends GetxController {
  final _repository = SignupLoginRepository();

  final status = Status.LOADING.obs;
  RxBool userBool = false.obs; // Use RxBool instead of bool
  RxBool isDone = false.obs;

  void setStatus(Status value) {
    status.value = value;
  }

  Future<void> postSignup(SignUP sendComment) async {
    try {
      setStatus(Status.LOADING);
      final success = await _repository.postSignup(sendComment);
      setStatus(success ? Status.COMPLETED : Status.ERROR);
      update(); // Trigger a rebuild
    } catch (e) {
      setStatus(Status.ERROR);
      print('Error posting signup: $e');
      update(); // Trigger a rebuild
    }
  }

  Future<void> postLogin(var data) async {
    try {
      setStatus(Status.LOADING);
      final success = await _repository.postlogin(data);

      setStatus(success ? Status.COMPLETED : Status.ERROR);
      update(); // Trigger a rebuild
    } catch (e) {
      setStatus(Status.ERROR);
      print('Error posting login: $e');
      update(); // Trigger a rebuild
    }
  }
}
