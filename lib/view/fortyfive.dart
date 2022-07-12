import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/typographydemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class FortyFive extends StatelessWidget {
  const FortyFive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FortyFiveStateFul();
  }
}

class FortyFiveStateFul extends StatefulWidget {
  const FortyFiveStateFul({Key? key}) : super(key: key);

  @override
  State<FortyFiveStateFul> createState() => FortyFiveStateFulState();
}

class FortyFiveStateFulState extends State<FortyFiveStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('FortyFive initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('FortyFive didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FortyFiveStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('FortyFive didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('FortyFive setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('FortyFive deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('FortyFive dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TypographyDemo();
  }

}