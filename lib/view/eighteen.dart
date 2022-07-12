import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_practice/set.dart';

import '../animation/animatedimagewidget.dart';
import '../animation/animationhero.dart';
import '../value/colorvalue.dart';

import 'dart:math' as math;

Set set = Set();

class Eighteen extends StatelessWidget {
  const Eighteen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: set.initText('Eighteen Page'),
      ),
      body: const SingleChildScrollView(
        child: EighteenStateFul(),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class EighteenStateFul extends StatefulWidget {
  const EighteenStateFul({Key? key}) : super(key: key);

  @override
  State<EighteenStateFul> createState() => EighteenState();
}

class EighteenState extends State<EighteenStateFul> with WidgetsBindingObserver, TickerProviderStateMixin{

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('Eighteen initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('Eighteen didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant EighteenStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('Eighteen didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('Eighteen setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('Eighteen deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('Eighteen dispose');
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
                    set.initText2('Animation 動畫', ColorValue.green, ColorValue.transParent, 24),
                    Padding(
                        padding: set.initEdgeInsets(15.0, 30.0, 15.0, 0.0),
                        child: Column(
                          children: [
                            set.initText2('Hero 動畫', ColorValue.black, ColorValue.transParent, 20),
                            const Center(
                                child: AnimationHero()
                            )
                          ],
                        )
                    ),
                    Padding(padding: set.initEdgeInsets(0.0, 30.0, 0.0, 0.0), child: const ScaleAnimationRoute(),),
                  ],
                )
             ),
          ],
        ),
      ),
    );
  }

  void _setLerp() {
    //a 为起始颜色，b为终止颜色，t为当前动画的进度[0,1]
    //Color.lerp(a, b, t);
    // Size.lerp(a, b, t)
    // Rect.lerp(a, b, t)
    // Offset.lerp(a, b, t)
    // Decoration.lerp(a, b, t)
    // Tween.lerp(t) //起始状态和终止状态在构建 Tween 的时候已经指定了
  }

}

class ShakeCurve extends Curve { // 過程曲線
  @override
  double transform(double t) {
    return math.sin(t * math.pi * 2);
  }
}

abstract class TickerProvider { // 刷新回調
  Ticker createTicker(TickerCallback onTick);
}