import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/material/gridlistdemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class FiftySeven extends StatelessWidget {
  const FiftySeven({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FiftySevenStateFul();
  }
}

class FiftySevenStateFul extends StatefulWidget {
  const FiftySevenStateFul({Key? key}) : super(key: key);

  @override
  State<FiftySevenStateFul> createState() => FiftySevenStateFulState();
}

class FiftySevenStateFulState extends State<FiftySevenStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('FiftySeven initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('FiftySeven didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FiftySevenStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('FiftySeven didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('FiftySeven setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('FiftySeven deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('FiftySeven dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridListDemo(type: GridListDemoType.footer,);
  }

}