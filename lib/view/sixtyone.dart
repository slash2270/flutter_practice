import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/cupertino/cupertinonavagationbardemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class SixtyOne extends StatelessWidget {
  const SixtyOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SixtyOneStateFul();
  }
}

class SixtyOneStateFul extends StatefulWidget {
  const SixtyOneStateFul({Key? key}) : super(key: key);

  @override
  State<SixtyOneStateFul> createState() => SixtyOneStateFulState();
}

class SixtyOneStateFulState extends State<SixtyOneStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('SixtyOne initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('SixtyOne didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SixtyOneStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('SixtyOne didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('SixtyOne setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('SixtyOne deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('SixtyOne dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBarDemo();
  }

}