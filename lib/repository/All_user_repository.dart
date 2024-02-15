import 'package:HappyLink/Models/All_users_model.dart';
import 'package:HappyLink/Models/UserModels.dart';
import 'package:HappyLink/data/baseApi.dart';
import 'package:HappyLink/data/network/Network_api_service.dart';

class AllUsersRepository {
  final _apiServices = NetworkApiService();

  Future<AllUsersModel?> getAllUserDetails() async {
    try {
      final String token = await getStoredCredentials('token');
      final dynamic response =
          await _apiServices.getApi(Urls.getalldata, token);
      AllUsersModel allusers = AllUsersModel.fromJson(response);
      return allusers;
    } catch (e) {
      print('Error fetching all user details: $e');
      return null;
    }
  }
}
