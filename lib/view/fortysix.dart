import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/material/transformationsdemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class FortySix extends StatelessWidget {
  const FortySix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FortySixStateFul();
  }
}

class FortySixStateFul extends StatefulWidget {
  const FortySixStateFul({Key? key}) : super(key: key);

  @override
  State<FortySixStateFul> createState() => FortySixStateFulState();
}

class FortySixStateFulState extends State<FortySixStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('FortySix initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('FortySix didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FortySixStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('FortySix didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('FortySix setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('FortySix deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('FortySix dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TransformationsDemo();
  }

}