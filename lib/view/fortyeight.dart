import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/material/appbardemo.dart';
import 'package:flutter_practice/gallery/material/navdrawerappbardemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class FortyEight extends StatelessWidget {
  const FortyEight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FortyEightStateFul();
  }
}

class FortyEightStateFul extends StatefulWidget {
  const FortyEightStateFul({Key? key}) : super(key: key);

  @override
  State<FortyEightStateFul> createState() => FortyEightStateFulState();
}

class FortyEightStateFulState extends State<FortyEightStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('FortyEight initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('FortyEight didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FortyEightStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('FortyEight didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('FortyEight setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('FortyEight deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('FortyEight dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavDrawerAppBarDemo();
  }

}