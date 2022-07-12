import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/box/customcheckbox.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/tools/custompaintwidget.dart';
import 'package:flutter_practice/renderobject/donewidget.dart';
import 'package:flutter_practice/tools/gradientbutton.dart';
import 'package:flutter_practice/tools/overflowboxexpandedpaintingarea.dart';
import 'package:flutter_practice/tools/richtextwidget.dart';
import 'package:flutter_practice/watermarker/textwatermarkpainter2.dart';
import 'package:flutter_practice/watermarker/textwatermarkpainterstagger2.dart';

import '../animation/turnbox.dart';
import '../tools/gradientcircularprogresswidget.dart';
import '../watermarker/textwatermarkpainter1.dart';
import '../watermarker/textwatermarkpainterstagger1.dart';
import '../watermarker/watermarkwidget.dart';

Set set = Set();

class TwentyOne extends StatelessWidget {
  const TwentyOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: set.initText('TwentyOne Page'),
        ),
      body: const SingleChildScrollView(
        child: TwentyOneStateFul(),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class TwentyOneStateFul extends StatefulWidget {
  const TwentyOneStateFul({Key? key}) : super(key: key);

  @override
  State<TwentyOneStateFul> createState() => TwentyOneState();
}

class TwentyOneState extends State<TwentyOneStateFul> with WidgetsBindingObserver {

  late GradientButton _gradientButton;
  late RichTextWidget _richTextWidget;
  late TextStyle _textStyle;
  String _strClick = 'click';
  double _turns = 0.0;
  bool _checked = false;
  final _strWA = 'WaterMarker+AfterLayout';
  final EdgeInsetsGeometry _paddingTop = const EdgeInsets.only(top: 20.0);
  final Duration _duration = const Duration(milliseconds: 1000);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('TwentyOne initState');
    }
    _textStyle = const TextStyle(color: Colors.green, backgroundColor: Colors.black, fontWeight: FontWeight.bold, fontSize: 36);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('TwentyOne didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant TwentyOneStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('TwentyOne didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('TwentyOne setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('TwentyOne deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('TwentyOne dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: set.initEdgeInsets(0.0, 20.0, 0.0, 20.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: [
                set.initText2('DoneWidget 自定義單選框', Colors.black, Colors.transparent, 24),
                const SizedBox(
                    width: 16,
                    height: 16,
                    child: DoneWidget(strokeWidth: 1, outline: false, color: Colors.purpleAccent)
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: DoneWidget(strokeWidth: 3, outline: true, color: Colors.purpleAccent)
                ),
                const SizedBox(
                    width: 30,
                    height: 30,
                    child: DoneWidget(strokeWidth: 5, outline: true, color: Colors.purpleAccent)
                ),
              ],
            ),
            Padding(
              padding: _paddingTop,
              child: Column(
                children: [
                  _gradientButton = GradientButton(
                    colors: const [Colors.orange, Colors.red],
                    height: 50.0,
                    child: set.initText2(_strClick, Colors.black, Colors.transparent, 24),
                    onPressed:(){
                      _onTap();
                    },
                  ),
                  _gradientButton = GradientButton(
                    height: 50.0,
                    colors: [Colors.lightGreen, Colors.green.shade700],
                    child: set.initText2(_strClick, Colors.black, Colors.transparent, 24),
                    onPressed:(){
                      _onTap();
                    },
                  ),
                  _gradientButton = GradientButton(
                      height: 50.0,
                      //borderRadius: const BorderRadius.all(Radius.circular(5)),
                      colors: [Colors.lightBlue.shade300, Colors.blueAccent],
                      child: set.initText2(_strClick, Colors.black, Colors.transparent, 24),
                      onPressed:(){
                        _onTap();
                      }
                  ),
                ],
              )
            ),
            TurnBox(
              turns: _turns,
              speed: 500,
              child: const Icon(
                Icons.refresh,
                size: 100,
              ),
            ),
            TurnBox(
              turns: _turns,
              speed: 1000,
              child: const Icon(
                Icons.refresh,
                size: 200.0,
              ),
            ),
            ElevatedButton(
              child: set.initText2("順時鐘旋轉1/2圈", Colors.white, Colors.transparent, 18),
              onPressed: () {
                setState(() {
                  _turns += 0.5;
                });
              },
            ),
            ElevatedButton(
              child: set.initText2("逆時鐘旋轉1/2圈", Colors.white, Colors.transparent, 18),
              onPressed: () {
                setState(() {
                  _turns -= 0.5;
                });
              },
            ),
            Padding(
              padding: _paddingTop,
              child: Column(
                children: [
                  _richTextWidget = RichTextWidget(text: 'RichText', linkStyle: _textStyle),
                  ElevatedButton(
                    child: set.initText2("變色", Colors.white, Colors.transparent, 18),
                    onPressed: () {
                      setState(() {
                        if(_textStyle.color == Colors.green){
                          _textStyle = const TextStyle(color: Colors.black, backgroundColor: Colors.green, fontWeight: FontWeight.normal, fontSize: 18);
                        }else{
                          _textStyle = const TextStyle(color: Colors.green, backgroundColor: Colors.black, fontWeight: FontWeight.bold, fontSize: 36);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: _paddingTop,
              child: Column(
                children: [
                  const CustomPaintWidget(),
                  ElevatedButton(onPressed: () {}, child: set.initText2('刷新', Colors.white, Colors.transparent, 18))
                ],
              ),
            ),
            Padding(
              padding: _paddingTop,
              child: Column(
                children: [
                  set.initText2('GradientCircularProgress\n圓形漸層進度條', Colors.black, Colors.transparent, 24),
                  GradientCircularProgressWidget(duration: _duration,)
                ],
              ),
            ),
            Padding(
              padding: _paddingTop,
              child: Column(
                children: [
                  set.initText2('CustomCheckBox 自定義複選框', Colors.black, Colors.transparent, 24),
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CustomCheckbox(
                      strokeWidth: 1,
                      radius: 1,
                      value: _checked,
                      onChanged: _onChange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: CustomCheckbox(
                      value: _checked,
                      onChanged: _onChange,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: CustomCheckbox(
                      strokeWidth: 3,
                      radius: 3,
                      value: _checked,
                      onChanged: _onChange,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: _paddingTop,
              child: Column(
                children: [
                  set.initText2(_strWA, Colors.black, Colors.transparent, 24),
                  set.textPainter(_strWA)
                ],
              ),
            ),
            Padding(
              padding: _paddingTop,
              child: Column(
                children: [
                  set.initText2('WaterMarker 浮水印1', Colors.black, Colors.transparent, 24),
                  Container(
                    width: 300,
                    height: 400,
                    color: Colors.grey.shade300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        IgnorePointer(
                          child: WaterMarkWidget(
                            painter: TextWaterMarkPainter1(
                              text: 'SlashTang',
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                                color: Colors.black38, //为了水印能更清晰一些，颜色深一点
                              ),
                              rotate: -30, // 旋转 -20 度
                            ),
                          ),
                        ),
                        ElevatedButton(onPressed: () {}, child: set.initText2('刷新', Colors.black, Colors.transparent, 18)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: _paddingTop,
              child: Column(
                children: [
                  set.initText2('WaterMarker 浮水印2', Colors.black, Colors.transparent, 24),
                  Container(
                    width: 300,
                    height: 400,
                    color: Colors.grey.shade300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        IgnorePointer(
                          child: WaterMarkWidget(
                            painter: TextWaterMarkPainter2(
                              text: 'SlashTang',
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white, //为了水印能更清晰一些，颜色深一点
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(onPressed: () {}, child: set.initText2('刷新', Colors.black, Colors.transparent, 18)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: _paddingTop,
              child: Column(
                children: [
                  set.initText2('WaterMarkStagger1', Colors.black, Colors.transparent, 24),
                  Container(
                    width: 300,
                    height: 400,
                    color: Colors.grey.shade300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        IgnorePointer(
                          child: WaterMarkWidget(
                            painter: TextWaterMarkPainterStagger1(
                              text: 'SlashTang',
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                                color: Colors.black38, //为了水印能更清晰一些，颜色深一点
                              ),
                              rotate: -25, // 旋转 -20 度
                              padding1: const EdgeInsets.only(left: 25),
                              padding2: const EdgeInsets.only(right: 25)
                            ),
                          ),
                        ),
                        ElevatedButton(onPressed: () {}, child: set.initText2('刷新', Colors.black, Colors.transparent, 18)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: _paddingTop,
              child: Column(
                children: [
                  set.initText2('WaterMarkStagger2', Colors.black, Colors.transparent, 24),
                  Container(
                    width: 300,
                    height: 400,
                    color: Colors.grey.shade300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        IgnorePointer(
                          child: WaterMarkWidget(
                            painter: TextWaterMarkPainterStagger2(
                              text: 'SlashTang',
                              textStyle: const TextStyle(
                                fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white, //为了水印能更清晰一些，颜色深一点
                              ),
                                padding1: const EdgeInsets.only(top: 25),
                                padding2: const EdgeInsets.only(bottom: 25)
                            ),
                          ),
                        ),
                        ElevatedButton(onPressed: () {}, child: set.initText2('刷新', Colors.black, Colors.transparent, 18)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: _paddingTop,
              child: Column(
                children: [
                  set.initText2('WaterMark 可滾動組件偏移', Colors.black, Colors.transparent, 24),
                  Container(
                    width: 300,
                    height: 400,
                    color: Colors.grey.shade300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        IgnorePointer(
                          child: LayoutBuilder(builder: (context, constraints) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Transform.translate(
                                offset: const Offset(-30, 0),
                                child: SizedBox(
                                  // constraints.maxWidth 为屏幕宽度，+30 像素
                                  width: constraints.maxWidth + 30,
                                  height: constraints.maxHeight,
                                  child: WaterMarkWidget(
                                    painter: TextWaterMarkPainterStagger1(
                                        text: 'SlashTang',
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w200,
                                          color: Colors.black38, //为了水印能更清晰一些，颜色深一点
                                        ),
                                        rotate: -25, // 旋转 -20 度
                                        padding1: const EdgeInsets.only(left: 25),
                                        padding2: const EdgeInsets.only(right: 25)
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        ElevatedButton(onPressed: () {}, child: set.initText2('刷新', Colors.black, Colors.transparent, 18)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: _paddingTop,
              child: Column(
                children: [
                  set.initText2('WaterMark FittedBox偏移', Colors.black, Colors.transparent, 24),
                  Container(
                    width: 300,
                    height: 400,
                    color: Colors.grey.shade300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        IgnorePointer(
                          child:  LayoutBuilder(
                            builder: (_, constraints) {
                              return FittedBox( // 取消父组件对子组件大小的约束
                                child: SizedBox(
                                  //指定 WaterMark 宽度比屏幕长 30 像素
                                  width: constraints.maxWidth - 30,
                                  height: constraints.maxHeight -30,
                                  child: WaterMarkWidget(
                                    painter: TextWaterMarkPainterStagger1(
                                        text: 'SlashTang',
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w200,
                                          color: Colors.black38, //为了水印能更清晰一些，颜色深一点
                                        ),
                                        rotate: -25, // 旋转 -20 度
                                        padding1: const EdgeInsets.only(left: 25),
                                        padding2: const EdgeInsets.only(right: 25)
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        ElevatedButton(onPressed: () {}, child: set.initText2('刷新', Colors.black, Colors.transparent, 18)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: _paddingTop,
              child: Column(
                children: [
                  set.initText2('WaterMark OverflowBox偏移', Colors.black, Colors.transparent, 24),
                  Container(
                    width: 300,
                    height: 400,
                    color: Colors.grey.shade300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        IgnorePointer(
                          child: OverflowBoxExpandedPaintingArea(
                            offset: const Offset(-30, 0),
                            child: WaterMarkWidget(
                              painter: TextWaterMarkPainterStagger1(
                                  text: 'SlashTang',
                                  textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black38, //为了水印能更清晰一些，颜色深一点
                                  ),
                                  rotate: -25, // 旋转 -20 度
                                  padding1: const EdgeInsets.only(left: 25),
                                  padding2: const EdgeInsets.only(right: 25)
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(onPressed: () {}, child: set.initText2('刷新', Colors.black, Colors.transparent, 18)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]
      ),
    );
  }

  void _onTap() {
    setState(() {
      if (_strClick == 'true') {
        _strClick = 'false';
      } else {
        _strClick = 'true';
      }
    });
  }

  void _onChange(value) {
    setState(() => _checked = value);
  }

}