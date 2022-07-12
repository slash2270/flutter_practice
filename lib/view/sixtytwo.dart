import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/cupertino/cupertinorefreshcontroldemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class SixtyTwo extends StatelessWidget {
  const SixtyTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SixtyTwoStateFul();
  }
}

class SixtyTwoStateFul extends StatefulWidget {
  const SixtyTwoStateFul({Key? key}) : super(key: key);

  @override
  State<SixtyTwoStateFul> createState() => SixtyTwoStateFulState();
}

class SixtyTwoStateFulState extends State<SixtyTwoStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('SixtyTwo initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('SixtyTwo didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SixtyTwoStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('SixtyTwo didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('SixtyTwo setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('SixtyTwo deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('SixtyTwo dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoRefreshControlDemo();
  }

}