import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:HappyLink/Models/All_Doctors_Model.dart';
import 'package:HappyLink/Models/UserModels.dart';
import 'package:HappyLink/User_View/views/SplashScreen/SplashScreen.dart';

import 'package:HappyLink/User_View/views/bottomNavigation/bottom_navigationbar.dart';
import 'package:HappyLink/User_View/views/common/Flutter_toast.dart';

class UserRepo {
  Future<void> signWithEmailAndPassword(String email, String password) async {
    try {
      // Sign up with email and password
      firebase_auth.UserCredential userCredential =
          await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Access the user information

      firebase_auth.User user = userCredential.user!;
      storeCredentials("FireToken", user.uid)
          .then((value) async => await Get.defaultDialog(
                title: "Login Successful",
                middleText: "Logged in Successfully",
                onConfirm: () {
                  // storeBoolCredentials('userType', true);
                  // Get.offAll(() => DoctorNavigationPage());
                  // } else {
                  // storeBoolCredentials('userType', false);
                  Get.offAll(() => SplashScreen());
                  // Get.offAll(() => DoctorNavigationPage());
                  // }
                },
                content: Container(
                  height: 200,
                  width: 400,
                  child: Lottie.asset("assets/PNGFiles/Login_done.json"),
                ),
              ))
          .onError((error, stackTrace) => showToast("Login failed"));

      // print('User details: ${use!.email}');
    } catch (e) {
      showToast(e.toString());
    }
  }

  // repositories/user_repository.dart

  Future<List<User>> getAllUsers() async {
    try {
      // Get the collection reference
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      QuerySnapshot querySnapshot = await usersCollection.get();
      List<User> users = querySnapshot.docs
          .map((doc) => User.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return users;
    } catch (e) {
      showToast(e.toString());
      return [];
    }
  }

  Future<User?> getCurrentUserInfo() async {
    User? user;
    final String firetoken = await getStoredCredentials('FireToken');
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection('users')
          .doc(firetoken)
          .get();
      if (!userInfo.exists) {
        return user;
      }

      user = User.fromJson(userInfo.data()!);
      storeCredentials("name", user.userDetails!.name);
      return user;
    } catch (e) {
      showToast(e.toString());
      return null;
    }
  }

  Future<Doctor?> getCurrentDoctorInfo() async {
    Doctor? user;
    final String firetoken = await getStoredCredentials('FireToken');
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(firetoken)
          .get();
      if (!userInfo.exists) {
        return user;
      }

      user = Doctor.fromJson(userInfo.data()!);
      storeCredentials("name", user.doctorDetails!.name);
      return user;
    } catch (e) {
      showToast(e.toString());
      return null;
    }
  }
}
