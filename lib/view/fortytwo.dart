import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/utils/screen/screenutildemo.dart';

Set set = Set();

class FortyTwo extends StatelessWidget {
  const FortyTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FortyTwoStateFul();
  }
}

class FortyTwoStateFul extends StatefulWidget {
  const FortyTwoStateFul({Key? key}) : super(key: key);

  @override
  State<FortyTwoStateFul> createState() => FortyTwoStateFulState();
}

class FortyTwoStateFulState extends State<FortyTwoStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('FortyTwo initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('FortyTwo didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FortyTwoStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('FortyTwo didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('FortyTwo setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('FortyTwo deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('FortyTwo dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilDemo();
  }

}