import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/animation/animationswidget.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/system/keyboardvisibility.dart';

Set set = Set();

class ThirtySeven extends StatelessWidget {
  const ThirtySeven({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: set.initText('ThirtySeven Page'),
        ),
        body: ThirtySevenStateFul()
    );
  }
}

class ThirtySevenStateFul extends StatefulWidget {
  const ThirtySevenStateFul({Key? key}) : super(key: key);

  @override
  State<ThirtySevenStateFul> createState() => ThirtySevenStateFulState();
}

class ThirtySevenStateFulState extends State<ThirtySevenStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('ThirtySeven initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('ThirtySeven didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ThirtySevenStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('ThirtySeven didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('ThirtySeven setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('ThirtySeven deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('ThirtySeven dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationsWidget()
    );
  }

}