// @dart = 2.9

import 'dart:core';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/styledwidget/styledwidgetdemo.dart';
import 'package:flutter_practice/styledwidget/styledwidgetjapan.dart';
import 'package:flutter_practice/styledwidget/stylewidgetlogo.dart';
import 'package:flutter_practice/styledwidget/stylewidgettoggle.dart';
import 'package:flutter_practice/video/smartplayerroute.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

Set set = Set();

class ThirtyTwo extends StatelessWidget {
  const ThirtyTwo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: set.initText('ThirtyTwo Page'),
      ),
      body: const SingleChildScrollView(
        child: ThirtyTwoStateFul()
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class ThirtyTwoStateFul extends StatefulWidget {
  const ThirtyTwoStateFul({Key key}) : super(key: key);

  @override
  State<ThirtyTwoStateFul> createState() => ThirtyTwoStateFulState();
}

class ThirtyTwoStateFulState extends State<ThirtyTwoStateFul> with WidgetsBindingObserver {

  DottedBorder _dottedBorder;
  Row _row;
  bool _isPress = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('ThirtyTwo initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('ThirtyTwo didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ThirtyTwoStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('ThirtyTwo didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('ThirtyTwo setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('ThirtyTwo deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('ThirtyTwo dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Path customPath = Path()
      ..moveTo(20, 20)
      ..lineTo(50, 100)
      ..lineTo(20, 200)
      ..lineTo(100, 100)
      ..lineTo(20, 20);
    return Padding(
      padding: set.initEdgeInsets(0.0, 20.0, 0.0, 20.0),
      child: Column(
        children: <Widget>[
          set.initText2('SmartPlayer 直播串流', Colors.black, Colors.transparent, 24),
          SmartPlayerRoute(),
          set.initSizedBox(20),
          set.initText2('DottedBorder 虛線邊框', Colors.black, Colors.transparent, 24),
          _row = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _dottedBorder = DottedBorder(
                color: Colors.black,
                strokeWidth: 1,
                child: FlutterLogo(size: 148),
              ),
              _dottedBorder = DottedBorder(
                customPath: (size) => customPath,
                // PathBuilder
                color: Colors.indigo,
                dashPattern: [8, 4],
                strokeWidth: 2,
                child: Container(
                  height: 220,
                  width: 120,
                  color: Colors.green.withAlpha(20),
                ),
              ),
            ],
          ),
          set.initSizedBox(15),
          _row = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _dottedBorder = DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                padding: EdgeInsets.all(6),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    height: 200,
                    width: 120,
                    color: Colors.amber,
                  ),
                ),
              ),
              _dottedBorder = DottedBorder(
                borderType: BorderType.RRect,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    height: 200,
                    width: 120,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
          set.initSizedBox(15),
          _row = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _dottedBorder = DottedBorder(
                borderType: BorderType.RRect,
                strokeWidth: 3,
                child: ClipRRect(
                  child: Container(
                    height: 200,
                    width: 120,
                    color: Colors.purpleAccent,
                  ),
                ),
              ),
              _dottedBorder = DottedBorder(
                borderType: BorderType.RRect,
                child: ClipRRect(
                  child: Container(
                    height: 200,
                    width: 120,
                    color: Colors.greenAccent,
                  ),
                ),
              ),
            ],
          ),
          set.initSizedBox(20),
          set.initText2('Styled Widget', Colors.black, Colors.transparent, 24),
          _row = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Text Test')
                  .padding(all: 10)
                  .backgroundColor(Colors.limeAccent)
                  .alignment(Alignment.center),
              set.initSizedBox(15),
              Align(
                alignment: Alignment.center,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.limeAccent,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('DecoratedBox Test'),
                  ),
                ),
              ),
            ],
          ),
          set.initSizedBox(15),
          _row = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('BorderRadius Test').decorated(
                color: Colors.limeAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              Styled.widget(child: Text('StyledWidget Test'))
                .padding(all: 20)
                .decorated(
                color: Colors.limeAccent,
                borderRadius: BorderRadius.circular(5),
              ).elevation(10),
            ],
          ),
          set.initSizedBox(15),
          _row = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.hardware)
                  .iconColor(Colors.grey.shade300)
                  .iconSize(18).decorated(
                color: Colors.limeAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              Styled.widget(child:  Icon(Icons.handyman)
                  .iconColor(Colors.grey.shade300)
                  .iconSize(18))
                  .padding(all: 20)
                  .decorated(
                color: Colors.limeAccent,
                borderRadius: BorderRadius.circular(5),
              ).elevation(10),
            ],
          ),
          set.initSizedBox(15),
          _row = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Animate Test', style: TextStyle(color: Colors.grey.shade300, backgroundColor: Colors.limeAccent),)
              .padding(
                all: 5,
                animate: true,
              ).animate(Duration(milliseconds: 300),Curves.easeOut),
              Icon(Icons.hail)
                  .iconColor(Colors.grey.shade300)
                  .iconSize(18)
                  .padding(all: 5, animate: true)
                  .animate(Duration(milliseconds: 300),Curves.elasticIn)
                  .backgroundColor(Colors.limeAccent)
                  .animate(Duration(milliseconds: 300),Curves.decelerate),
            ],
          ),
          set.initSizedBox(15),
          _row = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Styled.text('AnimateText Test', animate: true).bold().fontSize(18),
              Styled.icon(Icons.handshake, animate: true).iconColor(Colors.grey.shade300),
            ],
          ),
          set.initSizedBox(15),
          _row = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              styleWidgetButton(
                Text('Button Test')
                  .padding(all: 10)
                  .backgroundColor(Colors.limeAccent)
                  .alignment(Alignment.center),
              ),
              styleWidgetButton(
                  Icon(Icons.handshake_rounded)
                      .iconColor(Colors.grey.shade300)
                      .iconSize(18).decorated(
                    color: Colors.limeAccent,
                    borderRadius: BorderRadius.circular(5),
                  )
              )
            ],
          ),
          set.initSizedBox(15),
          SafeArea(child: StyleUserPage()),
          set.initText2('Japan Test', Colors.black, Colors.transparent, 20),
          StyledWidgetJapan(),
          set.initSizedBox(15),
          set.initText2('Logo Test', Colors.black, Colors.transparent, 20),
          StyledWidgetLogo(),
          set.initSizedBox(15),
          _row = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Basic Test')
                  .bold()
                  .fontSize(24)
                  .padding(all: 10)
                  .backgroundColor(Colors.limeAccent)
                  .alignment(Alignment.center),
              Align(
                alignment: Alignment.center,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.limeAccent,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Basic Test',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          set.initSizedBox(15),
          set.initText2('Toggle Test', Colors.black, Colors.transparent, 20),
          set.initSizedBox(10),
          StyleWidgetToggle(),
          set.initSizedBox(20),
          set.initText2('QR', Colors.black, Colors.transparent, 24),
          QrImage(
            data: "1234567890",
            version: QrVersions.auto,
            size: 200.0,
          ),
          QrImage(
            data: 'This is a simple QR code',
            version: QrVersions.auto,
            size: 320,
            gapless: false,
          ),
          QrImage(
            data: 'This QR code has an embedded image as well',
            version: QrVersions.auto,
            size: 320,
            gapless: false,
            embeddedImage: AssetImage('assets/images/home_button.png'),
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(80, 80),
            ),
          ),
          QrImage(
            data: 'This QR code will show the error state instead',
            version: 1,
            size: 320,
            gapless: false,
            errorStateBuilder: (cxt, err) {
              return Container(
                child: Center(
                  child: Text("Uh oh! Something went wrong...",
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget styleWidgetButton(Widget child) {
    return Styled.widget(child: child)
        .alignment(Alignment.center)
        .borderRadius(all: 15)
        .ripple()
        .backgroundColor(Colors.white, animate: true)
        .clipRRect(all: 25) // clip ripple
        .borderRadius(all: 25, animate: true)
        .elevation(
          _isPress ? 0 : 20,
          borderRadius: BorderRadius.circular(25),
          shadowColor: Color(0x30000000),
        )
        .constrained(height: 80)
        .padding(vertical: 12) // margin
        .gestures(
          onTapChange: (tapStatus) => setState(() => _isPress = tapStatus),
          onTapDown: (details) => print('ThirtyTwo tapDown'),
          onTap: () {
            _isPress = !_isPress;
            print('ThirtyTwo onTap');
          },
        )
        .scale(all: _isPress ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 150), Curves.linearToEaseOut);
  }

}