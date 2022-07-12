import 'dart:async';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/network/networkclient.dart';
import 'package:flutter_practice/set.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/constants.dart';
import '../value/colorvalue.dart';

Set set = Set();

class TwentyTwo extends StatelessWidget {
  const TwentyTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: set.initText('TwentyTwo Page'),
      ),
      body: const SingleChildScrollView(
        child: TwentyTwoStateFul(),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class TwentyTwoStateFul extends StatefulWidget {
  const TwentyTwoStateFul({Key? key}) : super(key: key);

  @override
  State<TwentyTwoStateFul> createState() => TwentyTwoState();
}

class TwentyTwoState extends State<TwentyTwoStateFul> with WidgetsBindingObserver {

  bool _loading = false;
  String _text = "";

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('TwentyTwo initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('TwentyTwo didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant TwentyTwoStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('TwentyTwo didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('TwentyTwo setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('TwentyTwo deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('TwentyTwo dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        set.initText2('HttpClient 網路請求', ColorValue.black, ColorValue.transParent, 24),
        Column(
          children: <Widget>[
            ElevatedButton(
              child: set.initText('Get'),
              onPressed: _loading ? null : request,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: set.initText(_text),
            ),
          ],
        ),
      ]),
    );
  }

  void request() async {
    setState(() {
      _loading = true;
      _text = "正在請求...";
    });
    try {
      _text = await NetWorkClient().getHttpClient(Constants.apiPhotos, '', '');
    } catch (e) {
      _text = "請求失敗：$e";
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

}