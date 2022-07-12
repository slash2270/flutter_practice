import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/material/datatabledemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class FiftyFour extends StatelessWidget {
  const FiftyFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FiftyFourStateFul();
  }
}

class FiftyFourStateFul extends StatefulWidget {
  const FiftyFourStateFul({Key? key}) : super(key: key);

  @override
  State<FiftyFourStateFul> createState() => FiftyFourStateFulState();
}

class FiftyFourStateFulState extends State<FiftyFourStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('FiftyFour initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('FiftyFour didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FiftyFourStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('FiftyFour didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('FiftyFour setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('FiftyFour deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('FiftyFour dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DataTableDemo();
  }

}