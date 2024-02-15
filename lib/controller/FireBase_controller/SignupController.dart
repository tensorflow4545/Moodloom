import 'package:get/get.dart';
import 'package:HappyLink/Models/All_Doctors_Model.dart';
import 'package:HappyLink/Models/UserModels.dart';
import 'package:HappyLink/User_View/views/SignupLogin/login.dart';
import 'package:HappyLink/repository/FireBase_Repo/UserRepo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SignUpControlller extends GetxController {
  final userRepo = Get.put(UserRepo());
  static SignUpControlller get instance => Get.find();

  Future<void> createUserDataInFirestore(String uid, User users) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(users.toJson());
      print('User data created in Firestore for UID: $uid');
    } catch (e) {
      print('Error creating user data in Firestore: $e');
    }
  }

  Future<void> signUpAndCreateUserData(User users) async {
    try {
      // Sign up with email and password
      firebase_auth.UserCredential userCredential = await firebase_auth
          .FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: users.email!,
        password: users.password!,
      );

      // Access the user information
      firebase_auth.User user = userCredential.user!;
      print('User signed up: ${user.uid}');

      // Create user data in Firestore
      await createUserDataInFirestore(user.uid, users)
          .then((value) => Get.to(() => Login()));
    } catch (e) {
      print('Error signing up and creating user data: $e');
    }
  }

  Future<void> createDoctorDataInFirestore(String uid, Doctor users) async {
    try {
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(uid)
          .set(users.toJson());
      print('User data created in Firestore for UID: $uid');
    } catch (e) {
      print('Error creating user data in Firestore: $e');
    }
  }

  Future<void> signUpAndCreateDoctorData(Doctor users, String password) async {
    try {
      // Sign up with email and password
      firebase_auth.UserCredential userCredential = await firebase_auth
          .FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: users.email!,
        password: password,
      );

      // Access the user information
      firebase_auth.User user = userCredential.user!;
      print('User signed up: ${user.uid}');

      // Create user data in Firestore
      await createDoctorDataInFirestore(user.uid, users)
          .then((value) => Get.to(() => Login()));
    } catch (e) {
      print('Error signing up and creating user data: $e');
    }
  }
}
