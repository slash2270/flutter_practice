import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/material/pickerdemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class Seventy extends StatelessWidget {
  const Seventy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SeventyStateFul();
  }
}

class SeventyStateFul extends StatefulWidget {
  const SeventyStateFul({Key? key}) : super(key: key);

  @override
  State<SeventyStateFul> createState() => SeventyStateFulState();
}

class SeventyStateFulState extends State<SeventyStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('Seventy initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('Seventy didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SeventyStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('Seventy didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('Seventy setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('Seventy deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('Seventy dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

}