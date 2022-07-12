import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/gallery/material/cardsdemo.dart';

Set set = Set();

class FiftyThree extends StatelessWidget {
  const FiftyThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FiftyThreeStateFul();
  }
}

class FiftyThreeStateFul extends StatefulWidget {
  const FiftyThreeStateFul({Key? key}) : super(key: key);

  @override
  State<FiftyThreeStateFul> createState() => FiftyThreeStateFulState();
}

class FiftyThreeStateFulState extends State<FiftyThreeStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('FiftyThree initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('FiftyThree didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FiftyThreeStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('FiftyThree didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('FiftyThree setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('FiftyThree deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('FiftyThree dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CardsDemo();
  }

}