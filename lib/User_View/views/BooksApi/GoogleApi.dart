import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleBooksApi {
  final String apiKey;

  GoogleBooksApi({required this.apiKey});

  Future<List<Map<String, dynamic>>> searchBooks(String query) async {
    final Uri uri = Uri.https(
      'www.googleapis.com',
      '/books/v1/volumes',
      {'q': query, 'key': apiKey},
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('items')) {
        List<Map<String, dynamic>> books = List<Map<String, dynamic>>.from(
          data['items'].map((book) => book['volumeInfo']),
        );
        return books;
      }
    }

    return [];
  }
}
