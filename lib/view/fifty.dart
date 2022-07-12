import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/material/bottomappbardemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class Fifty extends StatelessWidget {
  const Fifty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FiftyStateFul();
  }
}

class FiftyStateFul extends StatefulWidget {
  const FiftyStateFul({Key? key}) : super(key: key);

  @override
  State<FiftyStateFul> createState() => FiftyStateFulState();
}

class FiftyStateFulState extends State<FiftyStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('Fifty initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('Fifty didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FiftyStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('Fifty didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('Fifty setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('Fifty deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('Fifty dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBarDemo();
  }

}