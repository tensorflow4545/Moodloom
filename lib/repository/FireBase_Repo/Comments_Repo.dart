import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HappyLink/Models/CommentModel.dart';

class CommentRepo {
  Future<List<Comments>> getComments() async {
    try {
      // Get the collection reference
      CollectionReference commentsCollection =
          FirebaseFirestore.instance.collection('comments');
      QuerySnapshot querySnapshot = await commentsCollection.get();

      List<Comments> comments = querySnapshot.docs
          .map((doc) => Comments.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return comments;
    } catch (e) {
      print('Error getting comments from Firestore: $e');
      return [];
    }
  }

  putComment(Comments comments) async {
    // String firetoken = await getStoredCredentials("FireToken");
    try {
      await FirebaseFirestore.instance
          .collection('comments')
          .doc()
          .set(comments.toJson());
    } catch (e) {
      print('Error creating user data in Firestore: $e');
    }
  }
}
