import 'dart:convert';

import 'package:HappyLink/Models/SignUp.dart';
import 'package:HappyLink/Models/UserModels.dart';
import 'package:HappyLink/data/baseApi.dart';
import 'package:HappyLink/data/network/Network_api_service.dart';

class SignupLoginRepository {
  final _apiServices = NetworkApiService();

  Future<bool> postSignup(SignUP sendComment) async {
    try {
      final dynamic response = await _apiServices.postcommonApi(
          Urls.signup, jsonEncode(sendComment));
      print(response);
      if (response['message'] == 'User registered successfully') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error posting signup: $e');
      return false;
    }
  }

  Future<bool> postlogin(var data) async {
    try {
      final dynamic response = await _apiServices.loginapi(Urls.login, data);
      print(response);
      if (response['status'] == 'Login Successful') {
        storeCredentials('token', response['token']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error posting comment: $e');
      return false;
    }
  }
}
