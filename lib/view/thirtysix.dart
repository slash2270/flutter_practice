// @dart = 2.9

import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';


Set set = Set();

class ThirtySix extends StatelessWidget {
  const ThirtySix({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ThirtySixStateFul();
}

class ThirtySixStateFul extends StatefulWidget {
  const ThirtySixStateFul({Key key}) : super(key: key);

  @override
  State<ThirtySixStateFul> createState() => ThirtySixStateFulState();
}

class ThirtySixStateFulState extends State<ThirtySixStateFul> with WidgetsBindingObserver, AutomaticKeepAliveClientMixin, TickerProviderStateMixin {

  @override
  bool get wantKeepAlive => false; // 是否需要缓存

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('$state');
  }

  @override
  void initState() {
    print('ThirtySix initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    print('ThirtySix didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ThirtySixStateFul oldWidget) {
    // 元件發生變化
    print('ThirtySix didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    print('ThirtySix setState');
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    print('ThirtySix deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    print('ThirtySix dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

}