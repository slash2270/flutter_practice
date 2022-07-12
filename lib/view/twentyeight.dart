import 'dart:convert';
import 'dart:core';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/base/baseauth.dart';
import 'package:flutter_practice/firebase/firebaseappcheckdemo.dart';
import 'package:flutter_practice/firebase/firebasecloudmessagedemo.dart';
import 'package:flutter_practice/firebase/firebasecrashlyticsdemo.dart';
import 'package:flutter_practice/firebase/firebasedatabase.dart';
import 'package:flutter_practice/set.dart';

import '../firebase/message.dart';
import '../firebase/rootpage.dart';

Set set = Set();

class TwentyEight extends StatelessWidget {
  const TwentyEight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: set.initText('TwentyEight Page'),
      ),
      body: const SingleChildScrollView(
        child: TwentyEightStateFul(),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class TwentyEightStateFul extends StatefulWidget {
  const TwentyEightStateFul({Key? key}) : super(key: key);

  @override
  State<TwentyEightStateFul> createState() => TwentyEightState();
}

class TwentyEightState extends State<TwentyEightStateFul> with WidgetsBindingObserver, TickerProviderStateMixin{

  //统计
  late FirebaseAnalytics analytics;
  late FirebaseAnalyticsObserver observer;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('TwentyEight initState');
    }
    analytics = FirebaseAnalytics.instance;
    observer = FirebaseAnalyticsObserver(analytics: analytics);
    //analytics.logEvent(name: 'component', parameters: {'name': itemInfo.title});
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('TwentyEight didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant TwentyEightStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('TwentyEight didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('TwentyEight setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('TwentyEight deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('TwentyEight dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: set.initEdgeInsets(0.0, 20.0, 0.0, 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RootPage(
              auth: Auth()
          ),
          FirebaseDataBaseDemo(),
          FirebaseCrashlyticsDemo(),
          FirebaseAppCheckDemo(),
          FirebaseCloudMessageDemo(),
        ],
      ),
    );
  }

  void _sendAnalyticsEvent() async{
    //analytics = Provider.of<FirebaseAnalytics>(context);
    await analytics.logEvent(
      name: 'main_event',
      parameters: <String, dynamic>{
        'leftDrawerIconClick': '',
        'rightDrawerIconClick': ''
      },
    );
    /*await analytics.logBeginCheckout( // example
        value: 10.0,
        currency: 'USD',
        items: [
          AnalyticsEventItem(
              itemName: 'Socks',
              itemId: 'xjw73ndnw',
              price: 10.0
          ),
        ],
        coupon: '10PERCENTOFF'
    );*/
  }

}