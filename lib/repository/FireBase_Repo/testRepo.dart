import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HappyLink/Models/UserModels.dart';

class TestRepo {
  Future<User?> getCurrentUserInfo(String uid) async {
    User? user;
    try {
      final userInfo =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (!userInfo.exists) {
        return user;
      }
      user = User.fromJson(
          userInfo.data()!); // Adjust this line based on your User class
      return user;
    } catch (e) {
      print('Error getting user info: $e');
      return null;
    }
  }
}
