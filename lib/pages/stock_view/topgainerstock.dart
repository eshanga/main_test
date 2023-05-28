import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class topgainerstock extends StatefulWidget {
  const topgainerstock({Key? key}) : super(key: key);

  @override
  _topgainerstockState createState() => _topgainerstockState();
}

class _topgainerstockState extends State<topgainerstock> {
  late InAppWebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest:
            URLRequest(url: Uri.parse('https://finance.yahoo.com/gainers')),
        onWebViewCreated: (InAppWebViewController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
