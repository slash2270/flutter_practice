import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/material/gridlistdemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class FiftySix extends StatelessWidget {
  const FiftySix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FiftySixStateFul();
  }
}

class FiftySixStateFul extends StatefulWidget {
  const FiftySixStateFul({Key? key}) : super(key: key);

  @override
  State<FiftySixStateFul> createState() => FiftySixStateFulState();
}

class FiftySixStateFulState extends State<FiftySixStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('FiftySix initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('FiftySix didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FiftySixStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('FiftySix didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('FiftySix setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('FiftySix deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('FiftySix dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridListDemo(type: GridListDemoType.imageOnly,);
  }

}