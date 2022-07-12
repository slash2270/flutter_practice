import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';

import 'package:flutter_practice/gesturedetector/gesturedetectorwidget.dart';
import 'package:flutter_practice/pointerdownevent/hittestbehavior.dart';
import 'package:flutter_practice/pointerdownevent/hitstacktest.dart';
import 'package:flutter_practice/pointerdownevent/hittestblockertest.dart';
import 'package:flutter_practice/value/colorvalue.dart';

import '../pointerdownevent/pointermoveindicator.dart';

Set set = Set();

class Fifteen extends StatelessWidget {
  const Fifteen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: set.initText('Fifteen Page'),
        ),
        body: const SingleChildScrollView(
          child: FifteenStateFul(),
        ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class FifteenStateFul extends StatefulWidget {
  const FifteenStateFul({Key? key}) : super(key: key);

  @override
  State<FifteenStateFul> createState() => FifteenState();
}

class FifteenState extends State<FifteenStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('Fifteen initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('Fifteen didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FifteenStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('Fifteen didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('Fifteen setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('Fifteen deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('Fifteen dispose');
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
              padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
              child: Column(
                children: [
                  set.initText2('PointerEvent 原始指針事件', ColorValue.black, ColorValue.transParent, 24),
                  const PointerMoveIndicator(),
                ],
              )
            ),
            Padding(
                padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
                child: Column(
                  children: [
                    set.initText2('GestureDetector 手勢偵測事件', ColorValue.black, ColorValue.transParent, 24),
                    const GestureDetectorWidget(),
                  ],
                )
            ),
            Padding(
                padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
                child: set.initText2('事件分發機制', ColorValue.black, ColorValue.transParent, 24),
            ),
            Padding(
                padding: set.initEdgeInsets(15.0, 10.0, 15.0, 0.0),
                child: Column(
                  children: [
                    set.initText2('HitTestBehavior 命中測試', ColorValue.black, ColorValue.transParent, 20),
                    const HitTestBehaviorWidget()
                  ],
                )
            ),
            Padding(
                padding: set.initEdgeInsets(15.0, 0.0, 15.0, 0.0),
                child: Column(
                  children: const [
                    HitStackTest()
                  ],
                )
            ),
            Padding(
                padding: set.initEdgeInsets(15.0, 10.0, 15.0, 0.0),
                child: Column(
                  children: [
                    set.initText2('HitTestBlocker 命中測試', ColorValue.black, ColorValue.transParent, 20),
                    const HitTestBlockerTest()
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

}