import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/box/accuratesizedboxwidget.dart';
import 'package:flutter_practice/renderobject/customcenter.dart';
import 'package:flutter_practice/box/customrotatedbox1.dart';
import 'package:flutter_practice/renderobject/gowidget.dart';

import '../box/customrotatedbox2.dart';
import '../box/customrotatedbox5.dart';
import '../renderobject/afterlayout.dart';
import '../componentelement/customelementview.dart';
import '../box/customrotatedbox3.dart';
import '../box/customrotatedbox4.dart';
import '../renderobject/lefrrightbox.dart';
import '../value/colorvalue.dart';

Set set = Set();

class TwentyFive extends StatelessWidget {
  const TwentyFive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: set.initText('TwentyFive Page'),
      ),
        body: const SingleChildScrollView(
          child: TwentyFiveStateFul(),
        ),
        resizeToAvoidBottomInset: true,
    );
  }
}

class TwentyFiveStateFul extends StatefulWidget {
  const TwentyFiveStateFul({Key? key}) : super(key: key);

  @override
  State<TwentyFiveStateFul> createState() => TwentyFiveState();
}

class TwentyFiveState extends State<TwentyFiveStateFul> with WidgetsBindingObserver, TickerProviderStateMixin{

  int index = 0;
  String _strUpdate = '';
  final EdgeInsetsGeometry _paddingTop10 = const EdgeInsets.only(top: 10.0);
  final EdgeInsetsGeometry _paddingTop20 = const EdgeInsets.only(top: 20.0);
  late ElevatedButton _elevatedButton;
  late Rect _rect;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('TwentyFive initState');
    }
    _rect = Rect.zero;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('TwentyFive didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant TwentyFiveStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('TwentyFive didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('TwentyFive setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('TwentyFive deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('TwentyFive dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: [
                set.initText2('Element Tree 元素樹', Colors.black, Colors.transparent, 24),
                /*Padding(
                  padding: _paddingTop,
                  child: const Text(''),
                  //child: set.initText2('Size:${context.size}\nRenderObject:${context.findRenderObject()}\nTheme:${Theme.of(context)}', ColorValue.black, ColorValue.transParent, 20),
                ),*/
              ],
            ),
            Padding(
              padding: _paddingTop10,
              child: Column(
                children: [
                  set.initText2('CustomElement', ColorValue.black, ColorValue.transParent, 20),
                  const CustomElement(),
                ],
              ),
            ),
            Padding(
              padding: _paddingTop10,
              child: Column(
                children: [
                  set.initText2("setState", Colors.black, Colors.transparent, 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      set.initText2('State Index = ', ColorValue.black, ColorValue.transParent, 18),
                      set.initText2('$index', ColorValue.green, ColorValue.transParent, 18),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: _paddingTop10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _elevatedButton = ElevatedButton(
                    child: set.initText2("increase", Colors.white, Colors.transparent, 16),
                    onPressed: () {
                      setState(() {
                        ++index;
                      });
                    },
                  ),
                  _elevatedButton = ElevatedButton(
                    child: set.initText2("reduce", Colors.white, Colors.transparent, 16),
                    onPressed: () {
                      setState(() {
                        --index;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: _paddingTop10,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      set.initText2('Scheduler Phase = ', ColorValue.black, ColorValue.transParent, 18),
                      set.initText2(_strUpdate, ColorValue.green, ColorValue.transParent, 18),
                    ],
                  ),
                  _elevatedButton = ElevatedButton(
                    child: set.initText2("update", Colors.white, Colors.transparent, 18),
                    onPressed: () {
                      schedulerUpdate(() {
                      if(_strUpdate.isEmpty){
                        _strUpdate = 'true';
                      }else if(_strUpdate == 'true'){
                        _strUpdate = 'false';
                      }else if(_strUpdate == 'false'){
                        _strUpdate = '';
                      }
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: _paddingTop20,
              child: CustomCenter(child: set.initText2('CustomCenter', Colors.black, Colors.transparent, 24))
            ),
            Padding(
            padding: _paddingTop20,
            child: Container(
                color: Colors.green,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    set.initText2('LeftRightBox', Colors.black, Colors.transparent, 24),
                    LeftRightBox(
                      children: [
                        set.initText2('LeftBox', Colors.white, Colors.black, 20),
                        set.initText2('RightBox', Colors.white, Colors.black, 20)
                      ],
                    ),
                  ],
                ))),
            Padding(
                padding: _paddingTop20,
                child: Column(
                 children: [
                   set.initText2('AccurateSizedBoxWidget', Colors.black, Colors.transparent, 24),
                   const AccurateSizedBoxWidget()
                 ],
                )
            ),
            Padding(
                padding: _paddingTop20,
                child: Column(
                  children: [
                    set.initText2('AfterLayout', Colors.black, Colors.transparent, 24),
                    AfterLayout(
                      callback: (renderAfterLayout){
                        getRect(renderAfterLayout);
                      },
                      child: set.initText2('Size: ${_rect.size}', Colors.white, Colors.green, 20),
                    ),
                  ],
                )
            ),
            Padding(
                padding: _paddingTop20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    set.initText2('Align', Colors.black, Colors.transparent, 24),
                    Align(
                      child: Container(width: 100, height: 100, color: Colors.green),
                      alignment: Alignment.topLeft,
                    ),
                  ],
                )
            ),
            Padding(
                padding: _paddingTop20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    set.initText2('GoWidget', Colors.black, Colors.transparent, 24),
                    const GoWidget(),
                    ElevatedButton(
                      onPressed: () {
                        set.goOriginal();
                      },
                      child: set.initText2('setState', Colors.white, Colors.transparent, 18),
                    ),
                  ],
                )
            ),
            Padding(
                padding: _paddingTop20,
                child: Column(
                  children: [
                    set.initText2('CustomRotatedBox', Colors.black, Colors.transparent, 24),
                    const CustomRotatedBox1(
                      child: Text("A", textScaleFactor: 5, textAlign: TextAlign.center,),
                    ),
                    set.initText2('CustomRotatedBox+RepaintBoundary', Colors.black, Colors.transparent, 24),
                    const CustomRotatedBox1(
                        child: RepaintBoundary(
                          child: Text("A", textScaleFactor: 5, textAlign: TextAlign.center,),
                        )
                    ),
                    set.initText2('RepaintBoundary+pushLayer', Colors.black, Colors.transparent, 24),
                    const CustomRotatedBox2(
                      child: RepaintBoundary(
                        child: Text("A", textScaleFactor: 5, textAlign: TextAlign.center,),
                      )
                    ),
                    set.initText2('RepaintBoundary+pushTransform+1Parent', Colors.black, Colors.transparent, 24),
                    const CustomRotatedBox3(
                      child: Center( // 新添加
                        child: RepaintBoundary(
                          child: Text("A", textScaleFactor: 5, textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                    set.initText2('RepaintBoundary+pushTransform+needCompositing+1Parent', Colors.black, Colors.transparent, 24),
                    const CustomRotatedBox4(
                      child: Center( // 新添加
                        child: RepaintBoundary(
                          child: Text("A", textScaleFactor: 5, textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                    set.initText2('RepaintBoundary+pushTransform+flushCompositingBits+1Parent', Colors.black, Colors.transparent, 24),
                    const CustomRotatedBox5(
                      child: Center( // 新添加
                        child: RepaintBoundary(
                          child: Text("A", textScaleFactor: 5, textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                  ],
                )
            ),
      ]),
    );
  }

  void getRect(RenderAfterLayout renderAfterLayout) {
    setState(() {
      //我们需要获取的是AfterLayout子组件相对于Stack的Rect
      _rect = renderAfterLayout.localToGlobal(
        Offset.zero,
        //找到 Stack 对应的 RenderObject 对象
        ancestor: context.findRenderObject(),
      ) & renderAfterLayout.size;
    });
  }

  void schedulerUpdate(VoidCallback fn) {
    final schedulerPhase = SchedulerBinding.instance.schedulerPhase;
    if (schedulerPhase == SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(fn);
      });
    } else {
      setState(fn);
    }
  }

}

class CustomElement extends Widget {
  const CustomElement({Key? key}) : super(key: key);

  @override
  Element createElement() {
    return ComponentElementView(this);
  }
}