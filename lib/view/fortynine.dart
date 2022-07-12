import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/material/materialbannerdemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class FortyNine extends StatelessWidget {
  const FortyNine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FortyNineStateFul();
  }
}

class FortyNineStateFul extends StatefulWidget {
  const FortyNineStateFul({Key? key}) : super(key: key);

  @override
  State<FortyNineStateFul> createState() => FortyNineStateFulState();
}

class FortyNineStateFulState extends State<FortyNineStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('FortyNine initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('FortyNine didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FortyNineStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('FortyNine didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('FortyNine setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('FortyNine deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('FortyNine dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialBannerDemo();
  }

}