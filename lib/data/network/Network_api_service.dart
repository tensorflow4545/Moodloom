import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:HappyLink/data/network/Exception.dart';
import 'package:HappyLink/data/network/base_api_service.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future<dynamic> getApi(String url, String token) async {
    dynamic jsonResponse;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(Duration(seconds: 5));

      jsonResponse = returnResponse(response);
    } on TimeoutException {
      throw RequestTimeout("Request Time out");
    } on Exception catch (e) {
      throw e;
    }

    return jsonResponse;
  }

  @override
  Future<dynamic> getcommonApi(String url) async {
    dynamic jsonResponse;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 5));
      jsonResponse = returnResponse(response);
    } on TimeoutException {
      throw RequestTimeout("Request Time out");
    } on Exception catch (e) {
      throw e;
    }

    return jsonResponse;
  }

  Future<dynamic> postApi(
      String url, String? token, Map<String, dynamic> json) async {
    dynamic jsonResponse;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(json),
      );

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw InternetException('No Internet');
    } on TimeoutException {
      throw RequestTimeout('Request timeout occurred');
    } catch (e) {
      throw Exception('Error posting data: $e');
    }

    return jsonResponse;
  }

  Future<dynamic> postcommonApi(String url, var json) async {
    dynamic jsonResponse;
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(json),
      );

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw InternetException('No Internet');
    } on TimeoutException {
      throw RequestTimeout('Request timeout occurred');
    } catch (e) {
      throw Exception('Error posting data: $e');
    }

    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        throw InvalidUrlException();
      default:
        FetchDataException();
    }
  }

  @override
  Future<dynamic> loginapi(String url, var data) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(Duration(seconds: 5));
      jsonResponse = returnResponse(response);
    } on TimeoutException {
      throw RequestTimeout("Request Time out");
    } on Exception catch (e) {
      throw e;
    }

    return jsonResponse;
  }

  @override
  Future<void> uploadImage(String url, File imageFile, String userId) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(http.MultipartFile(
      'image',
      http.ByteStream(imageFile.readAsBytes().asStream()),
      imageFile.lengthSync(),
      filename: '$userId.jpg',
      // contentType: new MediaType('image', 'jpeg'),
    ));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
