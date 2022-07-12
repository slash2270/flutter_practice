import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/material/gridlistdemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class FiftyFive extends StatelessWidget {
  const FiftyFive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FiftyFiveStateFul();
  }
}

class FiftyFiveStateFul extends StatefulWidget {
  const FiftyFiveStateFul({Key? key}) : super(key: key);

  @override
  State<FiftyFiveStateFul> createState() => FiftyFiveStateFulState();
}

class FiftyFiveStateFulState extends State<FiftyFiveStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('FiftyFive initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('FiftyFive didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FiftyFiveStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('FiftyFive didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('FiftyFive setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('FiftyFive deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('FiftyFive dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridListDemo(type: GridListDemoType.header,);
  }

}