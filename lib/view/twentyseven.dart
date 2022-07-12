import 'dart:async';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import 'package:webview_flutter/webview_flutter.dart';

Set set = Set();

class TwentySeven extends StatelessWidget {
  const TwentySeven({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: set.initText('TwentySeven Page'),
      ),
      body: TwentySevenStateFul(),
    );
  }
}

class TwentySevenStateFul extends StatefulWidget {
  const TwentySevenStateFul({Key? key}) : super(key: key);

  @override
  State<TwentySevenStateFul> createState() => TwentySevenState();
}

class TwentySevenState extends State<TwentySevenStateFul> with WidgetsBindingObserver {

  late Completer<WebViewController> _controller;
  //late Timer _timer;
  double _value = 0.0;
  bool _isVisible = true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('TwentySeven initState');
    }
    _initWebView();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('TwentySeven didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant TwentySevenStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('TwentySeven didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('TwentySeven setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('TwentySeven deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('TwentySeven dispose');
    }
    //_timer.cancel();
    super.dispose();
  }

  _initWebView(){
    //_setTimer();
    _controller = Completer<WebViewController>();
    WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
      child: Stack(
        children: [
          set.initText2('WebView 網頁視窗', Colors.black, Colors.transparent, 24),
          WebView(
            initialUrl: 'www.youtube.com',
            javascriptMode: JavascriptMode.unrestricted,
            gestureNavigationEnabled: true,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              setState(() {
                _value = progress.toDouble();
                if(progress == 100){
                  _isVisible = false;
                }
              });
              //print("載入中... (progress : $progress%)");
            },
            navigationDelegate: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              //print('開始載入: $url');
            },
            onPageFinished: (String url) {
              //print('結束載入: $url');
            },
          ),
          Visibility(
            visible: _isVisible,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                  backgroundColor: Colors.black,
                  minHeight: 10,
                ),
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    backgroundColor: Colors.grey,
                  ),
                ),
                set.initText2('${_value.toInt()}%', Colors.black, Colors.transparent, 18)
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*double _setTimer(){
    _timer = Timer.periodic(Duration(milliseconds: 250), (timer) {
      setState(() {
        if (_value == 1.0) {
          _value = 0;
          _isVisible = false;
        }
        _value = NumberUtils.addNumber(_value, 0.1);
        /*if (_value >= 1.0) {
          _isVisible = false;
        }else {
          _value = NumberUtils.addNumber(_progressValue, 0.1);
        }*/
      });
    });
    return _value;
  }*/

}