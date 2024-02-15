import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:HappyLink/Models/CommentModel.dart';
import 'package:HappyLink/controller/FireBase_controller/CurrentUserController.dart';

import 'package:HappyLink/User_View/views/common/Flutter_toast.dart';
import 'package:HappyLink/repository/FireBase_Repo/Comments_Repo.dart';

class SlideUpTextField extends StatefulWidget {
  final String? category;
  SlideUpTextField({this.category});
  @override
  _SlideUpTextFieldState createState() => _SlideUpTextFieldState();
}

class _SlideUpTextFieldState extends State<SlideUpTextField> {
  // final CommentRepository commentRepository = CommentRepository();
  final TextEditingController messageController = TextEditingController();
  final currentUser = Get.find<CurrentUserController>();
  // final controller = Get.find<LoginController>();
  // final commentController = Get.find<CommentController>();
  final setComment = CommentRepo();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    hintText: 'Type something...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                child: IconButton(
                  onPressed: () async {
                    final String message = messageController.text;
                    late Comments newComment;
                    if (message.isNotEmpty &&
                        currentUser.userModel.value.userDetails?.name != null) {
                      newComment = Comments(
                        category: widget.category,
                        name: currentUser.userModel.value.userDetails?.name,
                        message: message,
                      );
                      // setState(() {
                      //   commentController.allComments.value.comments!
                      //       .add(newComment);
                      // });
                      await setComment.putComment(newComment);
                      // await commentRepository.postComment(newComment);
                      Navigator.pop(context);
                      showToast('Comment Added');
                    } else if (message.isNotEmpty &&
                        currentUser.doctor.value.doctorDetails?.name != null) {
                      newComment = Comments(
                        category: widget.category,
                        name: currentUser.doctor.value.doctorDetails?.name,
                        message: message,
                      );
                      // setState(() {
                      //   commentController.allComments.value.comments!
                      //       .add(newComment);
                      // });
                      await setComment.putComment(newComment);
                      // await commentRepository.postComment(newComment);
                      Navigator.pop(context);
                      showToast('Comment Added');
                    } else {
                      showToast('Comment message is empty');
                      Navigator.pop(context);
                      print('Comment message is empty');
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
