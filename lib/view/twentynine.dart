import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';

import '../video/videoplayerui.dart';

Set set = Set();

class TwentyNine extends StatelessWidget {
  const TwentyNine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TwentyNineStateFul();
  }
}

class TwentyNineStateFul extends StatefulWidget {
  const TwentyNineStateFul({Key? key}) : super(key: key);

  @override
  State<TwentyNineStateFul> createState() => TwentyNineState();
}

class TwentyNineState extends State<TwentyNineStateFul> with WidgetsBindingObserver, TickerProviderStateMixin{

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('TwentyNine initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('TwentyNine didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant TwentyNineStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('TwentyNine didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('TwentyNine setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('TwentyNine deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('TwentyNine dispose');
    }
    super.dispose();
  }

  // intl
  @override
  Widget build(BuildContext context) {
    return  Material(
      child: VideoPlayerUI.network(
        //url: 'https://gss3.baidu.com/6LZ0ej3k1Qd3ote6lo7D0j9wehsv/tieba-smallvideo-transcode-crf/60609889_0b5d29ee8e09fad4cc4f40f314d737ca_0.mp4',
        url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        title: '範例影片',
      )
    );
  }

}