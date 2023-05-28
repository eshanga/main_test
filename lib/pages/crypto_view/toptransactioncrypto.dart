import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class toptransactioncrypto extends StatefulWidget {
  const toptransactioncrypto({Key? key}) : super(key: key);

  @override
  _toptransactioncryptoState createState() => _toptransactioncryptoState();
}

class _toptransactioncryptoState extends State<toptransactioncrypto> {
  late InAppWebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse('https://cryptoslate.com/highest-volume/')),
        onWebViewCreated: (InAppWebViewController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
