import 'package:HappyLink/Models/Thoughts.dart';
import 'package:HappyLink/data/baseApi.dart';
import 'package:HappyLink/data/network/Network_api_service.dart';

class ThoughtsRepository {
  final _apiServices = NetworkApiService();

  Future<Thoughts?> thoughtsDetails() async {
    try {
      final dynamic response =
          await _apiServices.getcommonApi(Urls.getThoughts);
      Thoughts allThoughts = Thoughts.fromJson(response);
      return allThoughts;
    } catch (e) {
      print('Error fetching all user details: $e');
      return null;
    }
  }
}
