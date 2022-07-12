import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/material/bottomappbardemo.dart';
import 'package:flutter_practice/gallery/material/pickerdemo.dart';
import 'package:flutter_practice/gallery/material/tabnonscrollabledemo.dart';
import 'package:flutter_practice/gallery/material/textfielddemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class Sixty extends StatelessWidget {
  const Sixty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SixtyStateFul();
  }
}

class SixtyStateFul extends StatefulWidget {
  const SixtyStateFul({Key? key}) : super(key: key);

  @override
  State<SixtyStateFul> createState() => SixtyStateFulState();
}

class SixtyStateFulState extends State<SixtyStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('Sixty initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('Sixty didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SixtyStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('Sixty didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('Sixty setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('Sixty deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('Sixty dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldDemo();
  }

}