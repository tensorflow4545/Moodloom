import 'package:HappyLink/Models/CommentModel.dart';
import 'package:HappyLink/Models/UserModels.dart';
import 'package:HappyLink/data/baseApi.dart';
import 'package:HappyLink/data/network/Network_api_service.dart';

class CommentRepository {
  final _apiServices = NetworkApiService();

  Future<CommentModel?> getAllCommentDetails() async {
    try {
      final String token = await getStoredCredentials('token');
      final dynamic response =
          await _apiServices.getApi(Urls.getcomments, token);
      CommentModel comments = CommentModel.fromJson(response);
      return comments;
    } catch (e) {
      print('Error fetching all user details: $e');
      return null;
    }
  }

  Future<bool> postComment(Comments sendComment) async {
    try {
      final String token = await getStoredCredentials('token');
      final dynamic response = await _apiServices.postApi(
        Urls.getcomments,
        token,
        sendComment.toJson(),
      );
      print(response);
      if (response['message'] == 'Comment created successfully') {
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
