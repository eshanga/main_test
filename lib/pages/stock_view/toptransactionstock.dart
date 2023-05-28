import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class toptransactionstock extends StatefulWidget {
  const toptransactionstock({Key? key}) : super(key: key);

  @override
  _toptransactionstockState createState() => _toptransactionstockState();
}

class _toptransactionstockState extends State<toptransactionstock> {
  late InAppWebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest:
            URLRequest(url: Uri.parse('https://finance.yahoo.com/most-active')),
        onWebViewCreated: (InAppWebViewController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
