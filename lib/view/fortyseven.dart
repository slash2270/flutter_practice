import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/color/colorpickerdemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class FortySeven extends StatelessWidget {
  const FortySeven({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FortySevenStateFul();
  }
}

class FortySevenStateFul extends StatefulWidget {
  const FortySevenStateFul({Key? key}) : super(key: key);

  @override
  State<FortySevenStateFul> createState() => FortySevenStateFulState();
}

class FortySevenStateFulState extends State<FortySevenStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('FortySeven initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('FortySeven didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FortySevenStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('FortySeven didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('FortySeven setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('FortySeven deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('FortySeven dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColorPickerDemo();
  }

}