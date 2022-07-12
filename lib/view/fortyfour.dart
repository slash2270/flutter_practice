import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/colorsdemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class FortyFour extends StatelessWidget {
  const FortyFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FortyFourStateFul();
  }
}

class FortyFourStateFul extends StatefulWidget {
  const FortyFourStateFul({Key? key}) : super(key: key);

  @override
  State<FortyFourStateFul> createState() => FortyFourStateFulState();
}

class FortyFourStateFulState extends State<FortyFourStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('FortyFour initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('FortyFour didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FortyFourStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('FortyFour didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('FortyFour setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('FortyFour deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('FortyFour dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColorsDemo();
  }

}