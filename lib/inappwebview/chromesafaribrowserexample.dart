import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_practice/set.dart';

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {
    print("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    print("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    print("ChromeSafari browser closed");
  }
}

class ChromeSafariBrowserExample extends StatefulWidget {
  final ChromeSafariBrowser browser = new MyChromeSafariBrowser();

  @override
  _ChromeSafariBrowserExampleState createState() => new _ChromeSafariBrowserExampleState();
}

class _ChromeSafariBrowserExampleState extends State<ChromeSafariBrowserExample> {
  @override
  void initState() {
    widget.browser.addMenuItem(new ChromeSafariBrowserMenuItem(
        id: 1,
        label: 'Custom item menu 1',
        action: (url, title) {
          print('Custom item menu 1 clicked!');
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChromeSafariBrowser Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                await widget.browser.open(
                    url: Uri.parse("https://flutter.dev/"),
                    options: ChromeSafariBrowserClassOptions(
                        android: AndroidChromeCustomTabsOptions(
                            shareState: CustomTabsShareState.SHARE_STATE_OFF),
                        ios: IOSSafariOptions(barCollapsingEnabled: true)));
              },
              child: Text("Open Chrome Safari Browser")),
          Set().fortyThreePopScope(context)
        ],
      )
    );
  }

}