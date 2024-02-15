import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HappyLink/Models/CommentModel.dart';
import 'package:HappyLink/Models/FireBaseModels/Counselors_Model.dart';

class CounselorsRepo {
  Future<List<AllCounselors>> getComments() async {
    try {
      CollectionReference commentsCollection =
          FirebaseFirestore.instance.collection('Counselors');
      QuerySnapshot querySnapshot = await commentsCollection.get();

      List<AllCounselors> allCounselors = querySnapshot.docs
          .map((doc) =>
              AllCounselors.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return allCounselors;
    } catch (e) {
      print('Error getting comments from Firestore: $e');
      return [];
    }
  }
}
