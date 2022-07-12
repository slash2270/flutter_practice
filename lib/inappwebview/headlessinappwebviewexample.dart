import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_practice/set.dart';

class HeadlessInAppWebViewExample extends StatefulWidget {
  @override
  _HeadlessInAppWebViewExampleState createState() => new _HeadlessInAppWebViewExampleState();
}

class _HeadlessInAppWebViewExampleState extends State<HeadlessInAppWebViewExample> {
  HeadlessInAppWebView? headlessWebView;
  String url = "";

  @override
  void initState() {
    super.initState();

    headlessWebView = new HeadlessInAppWebView(
      initialUrlRequest:
      URLRequest(url: Uri.parse("https://github.com/flutter")),
      onWebViewCreated: (controller) {
        final snackBar = SnackBar(
          content: Text('HeadlessInAppWebView created!'),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      onConsoleMessage: (controller, consoleMessage) {
        final snackBar = SnackBar(
          content: Text('Console Message: ${consoleMessage.message}'),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      onLoadStart: (controller, url) async {
        final snackBar = SnackBar(
          content: Text('onLoadStart $url'),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() {
          this.url = url?.toString() ?? '';
        });
      },
      onLoadStop: (controller, url) async {
        final snackBar = SnackBar(
          content: Text('onLoadStop $url'),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() {
          this.url = url?.toString() ?? '';
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    headlessWebView?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "HeadlessInAppWebView Example",
            )),
        body: SafeArea(
            child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                    "URL: ${(url.length > 50) ? url.substring(0, 50) + "..." : url}"),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      await headlessWebView?.dispose();
                      await headlessWebView?.run();
                    },
                    child: Text("Run HeadlessInAppWebView")),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      if (headlessWebView?.isRunning() ?? false) {
                        await headlessWebView?.webViewController.evaluateJavascript(
                            source: "console.log('Here is the message!');");
                      } else {
                        final snackBar = SnackBar(
                          content: Text(
                              'HeadlessInAppWebView is not running. Click on "Run HeadlessInAppWebView"!'),
                          duration: Duration(milliseconds: 1500),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text("Send console.log message")),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      headlessWebView?.dispose();
                      setState(() {
                        this.url = '';
                      });
                    },
                    child: Text("Dispose HeadlessInAppWebView")),
              ),
              Set().fortyThreePopScope(context)
            ])));
  }
}