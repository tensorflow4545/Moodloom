import 'package:get/get.dart';
import 'package:HappyLink/Models/Sessions_model.dart';
import 'package:HappyLink/data/status.dart';
import 'package:HappyLink/repository/sessions_repository.dart';

class AllSessionsController extends GetxController {
  final _api = SessionsRepository();
  final AllSessions = SessionsModel(session: []).obs;
  final status = Status.LOADING.obs;

  void setStatus(Status value) {
    status.value = value;
  }

  void setAllSessions(SessionsModel value) {
    AllSessions.value = value;
  }

  void getAllSessions() {
    setStatus(Status.LOADING);
    _api.getAllSessionsDetails().then((value) {
      setStatus(Status.COMPLETED);
      if (value != null) {
        setAllSessions(value);
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
