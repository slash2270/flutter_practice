import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/material/pickerdemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class SixtyNine extends StatelessWidget {
  const SixtyNine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SixtyNineStateFul();
  }
}

class SixtyNineStateFul extends StatefulWidget {
  const SixtyNineStateFul({Key? key}) : super(key: key);

  @override
  State<SixtyNineStateFul> createState() => SixtyNineStateFulState();
}

class SixtyNineStateFulState extends State<SixtyNineStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('SixtyNine initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('SixtyNine didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SixtyNineStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('SixtyNine didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('SixtyNine setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('SixtyNine deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('SixtyNine dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

}