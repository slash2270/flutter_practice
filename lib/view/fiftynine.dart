import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/material/listdemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class FiftyNine extends StatelessWidget {
  const FiftyNine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FiftyNineStateFul();
  }
}

class FiftyNineStateFul extends StatefulWidget {
  const FiftyNineStateFul({Key? key}) : super(key: key);

  @override
  State<FiftyNineStateFul> createState() => FiftyNineStateFulState();
}

class FiftyNineStateFulState extends State<FiftyNineStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('FiftyNine initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('FiftyNine didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FiftyNineStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('FiftyNine didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('FiftyNine setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('FiftyNine deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('FiftyNine dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListDemo1(type: ListDemoType.twoLine);
  }

}