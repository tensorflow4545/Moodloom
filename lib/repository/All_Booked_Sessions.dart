import 'package:HappyLink/Models/All_Booked_Model.dart';

import 'package:HappyLink/data/baseApi.dart';
import 'package:HappyLink/data/network/Network_api_service.dart';

class AllBookedSessionRepository {
  final _apiServices = NetworkApiService();

  Future<AllBookedSessions?> getAllDoctorDetails() async {
    try {
      // final String token = await getStoredCredentials('token');
      final dynamic response =
          await _apiServices.getcommonApi(Urls.getAllBookedSessions);
      AllBookedSessions allbookedsessions =
          AllBookedSessions.fromJson(response);
      return allbookedsessions;
    } catch (e) {
      print('Error fetching all user details: $e');
      return null;
    }
  }
}
