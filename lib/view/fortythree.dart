import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/dartx/dartxdemo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class FortyThree extends StatelessWidget {
  const FortyThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: set.initText('FortyThree Page'),
        ),
        body: FortyThreeStateFul()
    );
  }
}

class FortyThreeStateFul extends StatefulWidget {
  const FortyThreeStateFul({Key? key}) : super(key: key);

  @override
  State<FortyThreeStateFul> createState() => FortyThreeStateFulState();
}

class FortyThreeStateFulState extends State<FortyThreeStateFul> with WidgetsBindingObserver {

  late ListTile _listTile;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('FortyThree initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('FortyThree didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FortyThreeStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('FortyThree didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('FortyThree setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('FortyThree deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('FortyThree dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: set.initPadding(0.0, 20.0, 0.0, 20.0, _getDrawer(context: context),),
    );
  }

  Drawer _getDrawer({required BuildContext context}) {
    return Drawer(
      child: Center(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
               child: set.initText('flutter_inappbrowser example'),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            _listTile = ListTile(
              title: set.initText('InAppBrowser'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/InAppBrowser');
              },
            ),
            _listTile = ListTile(
              title: set.initText('ChromeSafariBrowser'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/ChromeSafariBrowser');
              },
            ),
            _listTile = ListTile(
              title: set.initText('InAppWebView'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/InAppWebView');
              },
            ),
            _listTile = ListTile(
              title: set.initText('HeadlessInAppWebView'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/HeadlessInAppWebView');
              },
            ),
            set.initSizedBox(20.0),
            Container(
              height: 150,
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text('DartX', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            DartXDemo()

          ],
        ),
      ),
    );
  }

}
