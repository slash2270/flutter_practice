// @dart = 2.9

import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/permission/permissionhandlerwidget.dart';

Set set = Set();

class Forty extends StatelessWidget {
  const Forty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: set.initText('Forty Page'),
        ),
        body: FortyStateFul()
    );
  }
}

class FortyStateFul extends StatefulWidget {
  const FortyStateFul({Key key}) : super(key: key);

  @override
  State<FortyStateFul> createState() => FortyStateFulState();
}

class FortyStateFulState extends State<FortyStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('Forty initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('Forty didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FortyStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('Forty didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('Forty setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('Forty deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('Forty dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
          child: PermissionHandlerWidget()
          )
      );
  }

}