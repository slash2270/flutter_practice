import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/cupertino/cupertinosegmentedcontroldemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class SixtyThree extends StatelessWidget {
  const SixtyThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SixtyThreeStateFul();
  }
}

class SixtyThreeStateFul extends StatefulWidget {
  const SixtyThreeStateFul({Key? key}) : super(key: key);

  @override
  State<SixtyThreeStateFul> createState() => SixtyThreeStateFulState();
}

class SixtyThreeStateFulState extends State<SixtyThreeStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('SixtyThree initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('SixtyThree didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SixtyThreeStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('SixtyThree didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('SixtyThree setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('SixtyThree deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('SixtyThree dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSegmentedControlDemo();
  }

}