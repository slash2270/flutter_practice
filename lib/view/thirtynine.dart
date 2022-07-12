import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/tools/galleryexample.dart';

Set set = Set();

class ThirtyNine extends StatelessWidget {
  const ThirtyNine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: set.initText('ThirtyNine Page'),
        ),
        body: ThirtyNineStateFul()
    );
  }
}

class ThirtyNineStateFul extends StatefulWidget {
  const ThirtyNineStateFul({Key? key}) : super(key: key);

  @override
  State<ThirtyNineStateFul> createState() => ThirtyNineStateFulState();
}

class ThirtyNineStateFulState extends State<ThirtyNineStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('ThirtyNine initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('ThirtyNine didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ThirtyNineStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('ThirtyNine didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('ThirtyNine setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('ThirtyNine deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('ThirtyNine dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GalleryExample();
  }
}