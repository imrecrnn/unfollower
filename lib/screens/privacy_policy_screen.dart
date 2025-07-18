import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://baranimre.github.io/insfollow/privacy-policy.html'));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gizlilik Politikası'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
} 