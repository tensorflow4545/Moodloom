import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:HappyLink/utils/Theme_services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final themeService = Get.find<ThemeService>();

  late WebViewController _webViewController;
  bool _loadingError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeService.currentTheme.scafholdColor,
      appBar: AppBar(
        backgroundColor: themeService.currentTheme.primaryColor,
        elevation: 0,
        title: Text(
          "HappyLink",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 22, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            if (await _webViewController.canGoBack()) {
              _webViewController.goBack();
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _loadingError
                ? Center(
                    child: Text(
                      "Network Error. Please check your internet connection.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : WebView(
                    initialUrl: widget.url,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebResourceError: (error) {
                      setState(() {
                        _loadingError = true;
                      });
                    },
                    onWebViewCreated: (WebViewController controller) {
                      _webViewController = controller;
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
