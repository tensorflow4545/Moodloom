import 'package:HappyLink/Models/UserModels.dart';
import 'package:HappyLink/data/baseApi.dart';
import 'package:HappyLink/data/network/Network_api_service.dart';

class LoginRepository {
  final _apiServices = NetworkApiService();

  Future<UserModel?> getUserDetails() async {
    final String token = await getStoredCredentials('token');
    try {
      dynamic response = await _apiServices.getApi(Urls.getdata, token);
      UserModel users = UserModel.fromJson(response);
      storeCredentials('name', users.user!.userDetails!.name);
      return users;
    } catch (e) {
      return null;
    }
  }
}
