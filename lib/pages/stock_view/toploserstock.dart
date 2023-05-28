import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class toploserstock extends StatefulWidget {
  const toploserstock({Key? key}) : super(key: key);

  @override
  _toploserstockState createState() => _toploserstockState();
}

class _toploserstockState extends State<toploserstock> {
  late InAppWebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest:
            URLRequest(url: Uri.parse('https://finance.yahoo.com/losers')),
        onWebViewCreated: (InAppWebViewController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
