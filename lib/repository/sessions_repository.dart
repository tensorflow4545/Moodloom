import 'dart:convert';

import 'package:HappyLink/Models/Sessions_model.dart';
import 'package:HappyLink/Models/UserModels.dart';
import 'package:HappyLink/data/baseApi.dart';
import 'package:HappyLink/data/network/Network_api_service.dart';
import 'package:http/http.dart' as http;

class SessionsRepository {
  final _apiServices = NetworkApiService();

  Future<SessionsModel?> getAllSessionsDetails() async {
    try {
      final String token = await getStoredCredentials('token');
      final dynamic response =
          await _apiServices.getApi(Urls.getsessions, token);
      SessionsModel sessions = SessionsModel.fromJson(response);
      return sessions;
    } catch (e) {
      print('Error fetching all user details: $e');
      return null;
    }
  }
}

class SessionsApi {
  Future<SessionsModel?> getAllSessions() async {
    final String token = await getStoredCredentials('token');
    try {
      final response = await http.get(
        Uri.parse(Urls.getsessions), // Replace with your actual API endpoint
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return SessionsModel.fromJson(json.decode(response.body));
      } else {
        print('Failed to fetch sessions. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching sessions: $e');
      return null;
    }
  }
}
