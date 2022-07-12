import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/html/htmldemo.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/system/ipiftydemo.dart';
import 'package:flutter_practice/system/packageinfoplus.dart';

Set set = Set();

class SixtySix extends StatelessWidget {
  const SixtySix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SixtySixStateFul();
  }
}

class SixtySixStateFul extends StatefulWidget {
  const SixtySixStateFul({Key? key}) : super(key: key);

  @override
  State<SixtySixStateFul> createState() => SixtySixStateFulState();
}

class SixtySixStateFulState extends State<SixtySixStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('$state');
  }

  @override
  void initState() {
    print('SixtySix initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    print('SixtySix didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SixtySixStateFul oldWidget) {
    // 元件發生變化
    print('SixtySix didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    print('SixtySix setState');
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    print('SixtySix deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    print('SixtySix dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SixtySix Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            set.initSizedBox(20.0),
            IpiftyDemo(),
            set.initSizedBox(20.0),
            PackageInfoPlusDemo(),
            set.initSizedBox(20.0),
            HtmlDemo(),
            set.initSizedBox(20.0),
            //MoneyDemo(),
            //set.initSizedBox(20.0),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

}