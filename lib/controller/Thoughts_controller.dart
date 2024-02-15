import 'package:get/get.dart';
import 'package:HappyLink/Models/Thoughts.dart';
import 'package:HappyLink/data/status.dart';
import 'package:HappyLink/repository/thoughts_repository.dart';

class ThoughtsController extends GetxController {
  final _api = ThoughtsRepository();
  final AllThoughts = Thoughts().obs;
  final status = Status.LOADING.obs;

  void setStatus(Status value) {
    status.value = value;
  }

  void setAllThoughts(Thoughts value) {
    AllThoughts.value = value;
  }

  void postAllThpughts() {
    setStatus(Status.LOADING);
    _api.thoughtsDetails().then((value) {
      setStatus(Status.COMPLETED);
      if (value != null) {
        setAllThoughts(value);
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
