import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class toplosercrypto extends StatefulWidget {
  const toplosercrypto({Key? key}) : super(key: key);

  @override
  _toplosercryptoState createState() => _toplosercryptoState();
}

class _toplosercryptoState extends State<toplosercrypto> {
  late InAppWebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse('https://cryptoslate.com/biggest-losers/')),
        onWebViewCreated: (InAppWebViewController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
