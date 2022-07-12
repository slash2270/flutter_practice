import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/system/keyboardvisibility.dart';

Set set = Set();

class ThirtyFour extends StatelessWidget {
  const ThirtyFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: set.initText('ThirtyFour Page'),
      ),
      body: ThirtyFourStateFul()
    );
  }
}

class ThirtyFourStateFul extends StatefulWidget {
  const ThirtyFourStateFul({Key? key}) : super(key: key);

  @override
  State<ThirtyFourStateFul> createState() => ThirtyFourStateFulState();
}

class ThirtyFourStateFulState extends State<ThirtyFourStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('ThirtyFour initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('ThirtyFour didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ThirtyFourStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('ThirtyFour didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('ThirtyFour setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('ThirtyFour deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('ThirtyFour dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyBoardVisibility();
  }

}