import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/tools/expandablewidget.dart';

Set set = Set();

class ThirtyThree extends StatelessWidget {
  const ThirtyThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: set.initText('ThirtyThree Page'),
      ),
      body: ThirtyThreeStateFul()
    );
  }
}

class ThirtyThreeStateFul extends StatefulWidget {
  const ThirtyThreeStateFul({Key? key}) : super(key: key);

  @override
  State<ThirtyThreeStateFul> createState() => ThirtyThreeStateFulState();
}

class ThirtyThreeStateFulState extends State<ThirtyThreeStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('ThirtyThree initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('ThirtyThree didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ThirtyThreeStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('ThirtyThree didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('ThirtyThree setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('ThirtyThree deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('ThirtyThree dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ExpandableWidget(),
    );
  }

}