import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/animation/animatedswitchwidget.dart';
import 'package:flutter_practice/animation/animationImplicitlyanimatedwidget.dart';
import 'package:flutter_practice/animation/animationstaggerwidget.dart';
import 'package:flutter_practice/set.dart';

import '../value/colorvalue.dart';

Set set = Set();

class Nineteen extends StatelessWidget {
  const Nineteen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: set.initText('Nineteen Page'),
      ),
      body: const SingleChildScrollView(
        child: NineteenStateFul(),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class NineteenStateFul extends StatefulWidget {
  const NineteenStateFul({Key? key}) : super(key: key);

  @override
  State<NineteenStateFul> createState() => NineteenState();
}

class NineteenState extends State<NineteenStateFul> with WidgetsBindingObserver, TickerProviderStateMixin{

  final EdgeInsetsGeometry _paddingTop = const EdgeInsets.only(top: 20);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('Nineteen initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('Nineteen didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant NineteenStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('Nineteen didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('Nineteen setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('Nineteen deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('Nineteen dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
                padding: _paddingTop,
                child: set.initText2('Animation 動畫', ColorValue.black, ColorValue.transParent, 24),
            ),
            Padding(
                padding: _paddingTop,
                child: Column(
                  children: [
                    set.initText2('Stagger 動畫', ColorValue.black, ColorValue.transParent, 20),
                    const AnimationStaggerWidget()
                  ],
                )
             ),
            Padding(
                padding: _paddingTop,
                child: Column(
                  children: [
                    set.initText2('AnimatedSwitcher 動畫切換器', ColorValue.black, ColorValue.transParent, 20),
                    const AnimatedSwitcherWidget()
                  ],
                )
              ),
            Padding(
                padding: _paddingTop,
                child: Column(
                  children: [
                    set.initText2('ImplicitlyAnimatedWidget 隱式動畫小部件', ColorValue.black, ColorValue.transParent, 20),
                    const AnimatedImplicitlyAnimatedWidget()
                  ],
                )
            ),
           ].map((widget) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: widget,
            );
          }).toList(),
         ),
       ),
    );
  }

}