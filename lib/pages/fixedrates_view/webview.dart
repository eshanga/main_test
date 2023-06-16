import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../app_drawer.dart';

class WebView extends StatefulWidget {
  final String url;

  WebView({required this.url});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late InAppWebViewController _controller;
//  String _appBarTitle = 'Loading...';

//  void _updateAppBarTitle(String title) {
  //   setState(() {
  //   _appBarTitle = title;
  //  });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fixed Deposits Rates'),
        backgroundColor: Color.fromRGBO(80, 85, 88, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            if (await _controller.canGoBack()) {
              _controller.goBack();
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
        onWebViewCreated: (InAppWebViewController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
