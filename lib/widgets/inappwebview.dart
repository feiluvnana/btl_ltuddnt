import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AFBInAppWebView extends StatelessWidget {
  final Uri uri;
  const AFBInAppWebView({Key? key, required this.uri}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Purchase Page"),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: uri),
      ),
    );
  }
}
