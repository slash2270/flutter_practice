import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_practice/set.dart';

class MyInAppBrowser extends InAppBrowser {
  @override
  Future onBrowserCreated() async {
    print("Browser Created!");
  }

  @override
  Future onLoadStart(url) async {
    print("Started $url");
  }

  @override
  Future onLoadStop(url) async {
    print("Stopped $url");
  }

  @override
  void onLoadError(url, code, message) {
    print("Can't load $url.. Error: $message");
  }

  @override
  void onProgressChanged(progress) {
    print("Progress: $progress");
  }

  @override
  void onExit() {
    print("Browser closed!");
  }
}

class InAppBrowserExample extends StatefulWidget {
  final MyInAppBrowser browser = new MyInAppBrowser();

  @override
  State<InAppBrowserExample> createState() => _InAppBrowserExampleState();
}

class _InAppBrowserExampleState extends State<InAppBrowserExample> {
  var options = InAppBrowserClassOptions(
      crossPlatform: InAppBrowserOptions(hideUrlBar: false),
      inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InAppBrowser Example'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                widget.browser.openUrlRequest(
                    urlRequest: URLRequest(url: Uri.parse("https://flutter.dev")),
                    options: options);
              },
              child: Text("Open InAppBrowser")),
          Set().fortyThreePopScope(context)
        ],
      )
    );
  }

}