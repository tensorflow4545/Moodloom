import 'package:HappyLink/Models/All_Doctors_Model.dart';
import 'package:HappyLink/Models/UserModels.dart';
import 'package:HappyLink/data/baseApi.dart';
import 'package:HappyLink/data/network/Network_api_service.dart';

class AllDoctorsRepository {
  final _apiServices = NetworkApiService();

  Future<AllDoctorsModel?> getAllDoctorDetails() async {
    try {
      final String token = await getStoredCredentials('token');
      final dynamic response =
          await _apiServices.getApi(Urls.getdoctors, token);
      AllDoctorsModel alldoctors = AllDoctorsModel.fromJson(response);
      return alldoctors;
    } catch (e) {
      print('Error fetching all user details: $e');
      return null;
    }
  }
}
