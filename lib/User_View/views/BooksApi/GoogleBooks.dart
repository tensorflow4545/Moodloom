import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:HappyLink/User_View/views/BooksApi/GoogleApi.dart';
import 'package:HappyLink/utils/Theme_services.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BookSearchPage extends StatefulWidget {
  const BookSearchPage({Key? key}) : super(key: key);

  @override
  _BookSearchPageState createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  final String apiKey = 'AIzaSyBh3_EYMbI4leoG9XoN_oSRcmTqWzYPp6E';
  final TextEditingController _controller = TextEditingController();
  final themeService = Get.find<ThemeService>();
  List<bool> isSelected = [true, false, false, false];
  List<String> tags = ["Motivational", "Love", "Frictions", "SelfHelp"];

  List<Map<String, dynamic>> _books = [];

  void _searchBooks(String query) async {
    final googleBooksApi = GoogleBooksApi(apiKey: apiKey);
    final List<Map<String, dynamic>> books =
        await googleBooksApi.searchBooks(query);
    setState(() {
      _books = books;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchBooks(tags[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Search books',
          ),
          onSubmitted: (value) {
            _searchBooks(value);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              children: [
                Tags("Motivational", 0),
                Tags("Relationships", 1),
                Tags("Frictions", 2),
                Tags("Self Helps", 3),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                final book = _books[index];
                final smallThumbnailUrl = book['imageLinks']?['smallThumbnail'];

                return ListTile(
                  leading: smallThumbnailUrl != null
                      ? CachedNetworkImage(
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          imageUrl: smallThumbnailUrl,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(image: imageProvider),
                              ),
                            );
                          },
                        )
                      : SizedBox(
                          height: 50,
                          width: 50,
                          child:
                              Placeholder(), // Placeholder for cases where image is not available
                        ),
                  title: Text(book['title'] ?? 'Unknown Title'),
                  subtitle:
                      Text(book['authors']?.join(', ') ?? 'Unknown Author'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget Tags(String title, int no) {
    return GestureDetector(
      onTap: () {
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            if (i == no) {
              _searchBooks(tags[i]);
              isSelected[no] = true;
            } else {
              isSelected[i] = false;
            }
          }
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (isSelected[no])
                ? themeService.currentTheme.primaryColor
                : themeService.currentTheme.scafholdColor),
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
