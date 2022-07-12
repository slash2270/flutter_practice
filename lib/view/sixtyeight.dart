import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/tools/imagecropperdemo.dart';

Set set = Set();

class SixtyEight extends StatelessWidget {
  const SixtyEight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SixtyEightStateFul();
  }
}

class SixtyEightStateFul extends StatefulWidget {
  const SixtyEightStateFul({Key? key}) : super(key: key);

  @override
  State<SixtyEightStateFul> createState() => SixtyEightStateFulState();
}

class SixtyEightStateFulState extends State<SixtyEightStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('SixtyEight initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('SixtyEight didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SixtyEightStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('SixtyEight didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('SixtyEight setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('SixtyEight deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('SixtyEight dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ImageCropperDemo(title: 'Cropper');
  }

}