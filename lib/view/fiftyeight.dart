import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/material/listdemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class FiftyEight extends StatelessWidget {
  const FiftyEight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FiftyEightStateFul();
  }
}

class FiftyEightStateFul extends StatefulWidget {
  const FiftyEightStateFul({Key? key}) : super(key: key);

  @override
  State<FiftyEightStateFul> createState() => FiftyEightStateFulState();
}

class FiftyEightStateFulState extends State<FiftyEightStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('FiftyEight initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('FiftyEight didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FiftyEightStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('FiftyEight didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('FiftyEight setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('FiftyEight deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('FiftyEight dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListDemo2(type: ListDemoType.twoLine);
  }

}