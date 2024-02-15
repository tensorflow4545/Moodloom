import 'package:get/get.dart';
import 'package:HappyLink/Models/CommentModel.dart';
import 'package:HappyLink/data/status.dart';
import 'package:HappyLink/repository/Comment_repository.dart';

class CommentController extends GetxController {
  final _api = CommentRepository();
  final allComments = CommentModel().obs;
  final status = Status.LOADING.obs;
  RxList<bool> isSelected = <bool>[true, false, false].obs;
  RxInt category = 0.obs;

  void setSelectedIndex(int index) {
    for (int i = 0; i < isSelected.length; i++) {
      category.value = index;
      isSelected[i] = (i == index);
    }
    update();
  }

  void setStatus(Status value) {
    status.value = value;
  }

  void setAllUserModel(CommentModel value) {
    allComments.value = value;
  }

  void postAllComments() {
    setStatus(Status.LOADING);
    _api.getAllCommentDetails().then((value) {
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
