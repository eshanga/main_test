import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class topgainercrypto extends StatefulWidget {
  const topgainercrypto({Key? key}) : super(key: key);

  @override
  _topgainercryptoState createState() => _topgainercryptoState();
}

class _topgainercryptoState extends State<topgainercrypto> {
  late InAppWebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse('https://cryptoslate.com/biggest-gainers/')),
        onWebViewCreated: (InAppWebViewController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
