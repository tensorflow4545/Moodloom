import 'package:HappyLink/DataTest/TestModel.dart';
import 'package:HappyLink/User_View/views/common/Flutter_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HappyLink/Models/FireBaseModels/Counselors_Model.dart';

class AllSessionsRepo {
  Future<List<WeeklyAppointment>> getAllSessions() async {
    try {
      CollectionReference sessionsCollection =
          FirebaseFirestore.instance.collection('ScheduledSessions');
      QuerySnapshot querySnapshot = await sessionsCollection.get();

      List<WeeklyAppointment> allSessions = querySnapshot.docs
          .map((doc) =>
              WeeklyAppointment.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return allSessions;
    } catch (e) {
      print('Error getting sessions from Firestore: $e');
      return [];
    }
  }

  putSessions(Allslots sessions) async {
    // String firetoken = await getStoredCredentials("FireToken");
    try {
      await FirebaseFirestore.instance
          .collection('BookedSessions')
          .doc()
          .set(sessions.toJson())
          .whenComplete(() => showToast("SuccessFully Booked"));
    } catch (e) {
      print('Error creating user data in Firestore: $e');
    }
  }

  Future<List<Allslots>> getEachCounselorSessions(String counselorId) async {
    try {
      CollectionReference sessionsCollection =
          FirebaseFirestore.instance.collection('BookedSessions');
      QuerySnapshot querySnapshot = await sessionsCollection
          .where("counselorId", isEqualTo: counselorId)
          .get();

      List<Allslots> counselorSessions = querySnapshot.docs
          .map((doc) => Allslots.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return counselorSessions;
    } catch (e) {
      print('Error getting sessions from Firestore: $e');
      return [];
    }
  }

  Future<List<Allslots>> getEachDeletedSessions(String counselorId) async {
    try {
      CollectionReference sessionsCollection =
          FirebaseFirestore.instance.collection('DeletedSessions');
      QuerySnapshot querySnapshot = await sessionsCollection
          .where("counselorId", isEqualTo: counselorId)
          .get();

      List<Allslots> counselorSessions = querySnapshot.docs
          .map((doc) => Allslots.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return counselorSessions;
    } catch (e) {
      print('Error getting sessions from Firestore: $e');
      return [];
    }
  }
}
