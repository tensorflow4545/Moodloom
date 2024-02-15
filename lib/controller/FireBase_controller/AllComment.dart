import 'package:get/get.dart';
import 'package:HappyLink/Models/CommentModel.dart';
import 'package:HappyLink/repository/FireBase_Repo/Comments_Repo.dart';

class AllCommentController extends GetxController {
  final CommentRepo commentRepo = CommentRepo();
  List<Comments> allComments = <Comments>[].obs;
  RxInt category = 0.obs;
  RxList<bool> isSelected = <bool>[true, false, false].obs;

  @override
  void onInit() {
    super.onInit();
    getComments();
  }

  void setSelectedIndex(int index) {
    for (int i = 0; i < isSelected.length; i++) {
      category.value = index;
      isSelected[i] = (i == index);
    }
    update();
  }

  Future<void> getComments() async {
    allComments = await commentRepo.getComments();
    update();
  }
}
