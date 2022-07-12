import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/bottomnavigation/bottomnavagationdemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class FiftyOne extends StatelessWidget {
  const FiftyOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FiftyOneStateFul();
  }
}

class FiftyOneStateFul extends StatefulWidget {
  const FiftyOneStateFul({Key? key}) : super(key: key);

  @override
  State<FiftyOneStateFul> createState() => FiftyOneStateFulState();
}

class FiftyOneStateFulState extends State<FiftyOneStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('FiftyOne initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('FiftyOne didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FiftyOneStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('FiftyOne didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('FiftyOne setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('FiftyOne deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('FiftyOne dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationDemo(restorationId: '1', type: BottomNavigationDemoType.withoutLabels);
  }

}