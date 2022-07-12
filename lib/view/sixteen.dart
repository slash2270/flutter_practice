import 'dart:async';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gesturedetector/customtapgesturerecognizer.dart';
import 'package:flutter_practice/model/eventbus.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/view/twenty.dart';

import '../gesturedetector/customgesturedetector.dart';
import '../value/colorvalue.dart';

Set set = Set();
const String _sendTransaction = '顯示EventBus';
String _catchBus = _sendTransaction;
late StreamSubscription _eventBusSubscript;

class Sixteen extends StatelessWidget {
  const Sixteen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: set.initText('Sixteen Page'),
      ),
      body:  const SingleChildScrollView(
        child: SixteenStateFul(),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class SixteenStateFul extends StatefulWidget {
  const SixteenStateFul({Key? key}) : super(key: key);

  @override
  State<SixteenStateFul> createState() => SixteenState();
}

class SixteenState extends State<SixteenStateFul> with WidgetsBindingObserver {

  bool _toggle = false; //变色开关
  String _drag = '拖曳';
  double _top = 0.0, _left = 0.0;
  late TapGestureRecognizer _tapGestureRecognizer;
  late CustomTapGestureRecognizer customTapGestureRecognizer;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('Sixteen initState');
    }
    _tapGestureRecognizer = TapGestureRecognizer();
    customTapGestureRecognizer = CustomTapGestureRecognizer();
    getEventBus();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('Sixteen didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SixteenStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('Sixteen didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('Sixteen setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('Sixteen deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('Sixteen dispose');
    }
    _eventBusSubscript.cancel();
    _tapGestureRecognizer.dispose();
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
                padding: set.initEdgeInsets(15.0, 20.0, 15.0, 0.0),
                child: Center(
                  child: Column(
                    children: [
                      _setRecognizer()
                    ],
                  ),
                )
            ),
            Padding(
                padding: set.initEdgeInsets(15.0, 20.0, 15.0, 0.0),
                child: Column(
                  children: [
                    set.initText2('多手勢衝突', ColorValue.black, ColorValue.transParent, 24),
                  ],
                )
            ),
            Padding(
                padding: set.initEdgeInsets(15.0, 10.0, 15.0, 0.0),
                child: Column(
                  children: [
                    set.initText2('Listener 解決', ColorValue.black, ColorValue.transParent, 20),
                    _setListener(),
                    set.initText2('Recognizer 解決', ColorValue.black, ColorValue.transParent, 20),
                    _setCustomRecognizer(),
                  ],
                )
            ),
            Padding(
                padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
                child: Column(
                  children: [
                    set.initText2('事件總覽', ColorValue.black, ColorValue.transParent, 20),
                    const TransactionButton(),
                    set.initText2(_catchBus, ColorValue.black, ColorValue.transParent, 16),
                  ],
               )
             ),
          ],
        ),
      ),
    );
  }

  void getEventBus(){
    _eventBusSubscript = EventBusUtils.getInstance().on<EventBusBroadCast>().listen((event) {
      setState(() {
        _catchBus = event.transaction;
        debugPrint('Sixteen CatchBus = $_catchBus');
      });
    });
  }

  Widget _setRecognizer() {
    return Container(
        alignment: Alignment.center,
        color: Colors.purpleAccent,
        width: 300.0,
        height: 225.0,
        child: Center(
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                    text: 'TapGestureRecognizer',
                    style: TextStyle(fontSize: 20)),
                TextSpan(
                  text: "\n點我變色\n",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: _toggle ? Colors.blue : Colors.red,
                  ),
                  recognizer: _tapGestureRecognizer
                    ..onTap = () {
                      setState(() {
                        _toggle = !_toggle;
                      });
                    },
                ),
                const TextSpan(text: '必須dispose', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ));
  }

  Widget _setListener() {
    return Container(
      alignment: Alignment.center,
      color: Colors.lightGreen,
      width: 300.0,
      height: 225.0,
      child: Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: SizedBox(
              height: 150,
              width: 150,
              child: CircleAvatar(
                  backgroundColor: ColorValue.black,
                  child: set.initText2(_drag, Colors.white, ColorValue.transParent, 20)),
            ),
            onVerticalDragUpdate: (DragUpdateDetails details) {
              // 垂直方向拖动事件
              setState(() {
                _top += details.delta.dy;
              });
              dragText('垂直移動: $_top');
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              // 水平方向拖动事件
              setState(() {
                _left += details.delta.dx;
              });
              dragText('水平移動: $_left');
            },
          )),
    );
  }

  void dragText(String text) {
    //更新显示的事件名
    setState(() {
      _drag = text;
    });
  }

  Widget _setCustomRecognizer() {
    return Container(
      alignment: Alignment.center,
      color: Colors.yellowAccent.shade100,
      width: 300.0,
      height: 225.0,
      child: const CustomGestureDetector()
    );
  }

}

class TransactionButton extends StatefulWidget {
  const TransactionButton({Key? key}) : super(key: key);

  @override
  State<TransactionButton> createState() => _TransactionButtonState();
}

class _TransactionButtonState extends State<TransactionButton> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
      ElevatedButton(
          child: set.initText2('發送EventBus', Colors.black, ColorValue.transParent, 16),
          onPressed: () {
            EventBusUtils.getInstance().fire(EventBusBroadCast('Hello World!'));
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Twenty(),
                    settings: const RouteSettings(
                      arguments: '',
                    )
                ));
          }),
    ]);
  }
}