import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/material/bottomsheetdemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class FiftyTwo extends StatelessWidget {
  const FiftyTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FiftyTwoStateFul();
  }
}

class FiftyTwoStateFul extends StatefulWidget {
  const FiftyTwoStateFul({Key? key}) : super(key: key);

  @override
  State<FiftyTwoStateFul> createState() => FiftyTwoStateFulState();
}

class FiftyTwoStateFulState extends State<FiftyTwoStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('FiftyTwo initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('FiftyTwo didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FiftyTwoStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('FiftyTwo didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('FiftyTwo setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('FiftyTwo deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('FiftyTwo dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetDemo();
  }

}