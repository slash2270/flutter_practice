import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherWidget extends StatefulWidget {
  const UrlLauncherWidget({Key? key}) : super(key: key);

  @override
  State<UrlLauncherWidget> createState() => _UrlLauncherWidgetState();
}

class _UrlLauncherWidgetState extends State<UrlLauncherWidget> {
  bool _hasCallSupport = false;
  Future<void>? _launched;
  String _phone = '';

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewWithoutJavaScript(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewWithoutDomStorage(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableDomStorage: false),
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchUniversalLinkIos(Uri url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    // onPressed calls using this URL are not gated on a 'canLaunch' check
    // because the assumption is that every device can launch a web URL.
    final Uri toLaunch = Uri(scheme: 'https', host: 'www.cylog.org', path: 'headers/');
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
              onChanged: (String text) => _phone = text,
              decoration: const InputDecoration(hintText: '輸入電話號碼以啟動')),
        ),
        ElevatedButton(
          onPressed: _hasCallSupport
              ? () => setState(() {
            _launched = _makePhoneCall(_phone);
          })
              : null,
          child: _hasCallSupport
              ? const Text('撥打電話')
              : const Text('不支持調用'),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(toLaunch.toString()),
        ),
        ElevatedButton(
          onPressed: () => setState(() {
            _launched = _launchInBrowser(toLaunch);
          }),
          child: const Text('在瀏覽器中啟動'),
        ),
        const Padding(padding: EdgeInsets.all(16.0)),
        ElevatedButton(
          onPressed: () => setState(() {
            _launched = _launchInWebViewOrVC(toLaunch);
          }),
          child: const Text('在應用程序中啟動'),
        ),
        ElevatedButton(
          onPressed: () => setState(() {
            _launched = _launchInWebViewWithoutJavaScript(toLaunch);
          }),
          child: const Text('在應用程序中啟動 (JavaScript OFF)'),
        ),
        ElevatedButton(
          onPressed: () => setState(() {
            _launched = _launchInWebViewWithoutDomStorage(toLaunch);
          }),
          child: const Text('在應用程序中啟動 (DOM 存儲關閉)'),
        ),
        const Padding(padding: EdgeInsets.all(16.0)),
        ElevatedButton(
          onPressed: () => setState(() {
            _launched = _launchUniversalLinkIos(toLaunch);
          }),
          child: const Text('在原生應用中啟動通用鏈接，回退到 Safari.(Youtube)'),
        ),
        const Padding(padding: EdgeInsets.all(16.0)),
        ElevatedButton(
          onPressed: () => setState(() {
            _launched = _launchInWebViewOrVC(toLaunch);
            Timer(const Duration(seconds: 5), () {
              print('UrlLauncher Closing WebView after 5 seconds...');
              closeInAppWebView();
            });
          }),
          child: const Text('在應用中啟動 + 5 秒後關閉'),
        ),
        const Padding(padding: EdgeInsets.all(16.0)),
        Link(
          uri: Uri.parse('https://pub.dev/documentation/url_launcher/latest/link/link-library.html'),
          target: LinkTarget.blank,
          builder: (BuildContext ctx, FollowLink? openLink) {
            return TextButton.icon(
              onPressed: openLink,
              label: const Text('鏈接小部件文檔'),
              icon: const Icon(Icons.read_more),
            );
          },
        ),
        const Padding(padding: EdgeInsets.all(16.0)),
        FutureBuilder<void>(future: _launched, builder: _launchStatus),
      ],
    );
  }
}