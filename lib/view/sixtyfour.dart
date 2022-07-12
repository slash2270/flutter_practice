import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/cupertino/cupertinotabbardemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class SixtyFour extends StatelessWidget {
  const SixtyFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SixtyFourStateFul();
  }
}

class SixtyFourStateFul extends StatefulWidget {
  const SixtyFourStateFul({Key? key}) : super(key: key);

  @override
  State<SixtyFourStateFul> createState() => SixtyFourStateFulState();
}

class SixtyFourStateFulState extends State<SixtyFourStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('SixtyFour initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('SixtyFour didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SixtyFourStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('SixtyFour didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('SixtyFour setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('SixtyFour deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('SixtyFour dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBarDemo();
  }

}