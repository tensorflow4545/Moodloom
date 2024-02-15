import 'dart:io';

abstract class BaseApiService {
  Future<dynamic> getApi(String url, String token);
  Future<dynamic> getcommonApi(String url);
  Future<dynamic> loginapi(String url, var data);
  Future<dynamic> postcommonApi(String url, var data);
  Future<void> uploadImage(String url, File imageFile, String userId);

  Future<dynamic> postApi(
    String url,
    String? token,
    Map<String, dynamic> data,
  );
}
