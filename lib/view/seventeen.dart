import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/notification/notificationwidget.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/value/colorvalue.dart';

Set set = Set();

class Seventeen extends StatelessWidget {
  const Seventeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // 返回一个 Sliver 数组给外部可滚动组件。
            return <Widget>[
              SliverAppBar(
                title: const Text('Seventeen Page'),
                pinned: true, // 固定在顶部
                forceElevated: innerBoxIsScrolled,
              ),
              const SliverOpacity(
                // 透明度
                opacity: 0.5,
                sliver: SliverToBoxAdapter(
                    child: Text(
                  'NestedScrollView',
                  style: TextStyle(
                      color: Colors.black,
                      backgroundColor: Colors.transparent,
                      fontSize: 20),
                )),
              ),
              SliverFixedExtentList(
                itemExtent: 50.0,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    //创建列表项
                    return Container(
                        alignment: Alignment.center,
                        color: Colors.blueGrey[100 * (index % 9)],
                        child: set.initText('list item $index'));
                  },
                  childCount: 10,
                ),
              ),
              SliverOpacity(
                // 透明度
                opacity: 0.5,
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      set.initText2('Notification 通知', ColorValue.black,
                          ColorValue.transParent, 24),
                      const NotificationWidget()
                    ],
                  ),
                ),
              ),
            ];
          },
          body: const SeventeenStateFul()),
    );
  }
}

class SeventeenStateFul extends StatefulWidget {
  const SeventeenStateFul({Key? key}) : super(key: key);

  @override
  State<SeventeenStateFul> createState() => SeventeenState();
}

class SeventeenState extends State<SeventeenStateFul> with WidgetsBindingObserver{

  String _strScroll = '滑動監聽';

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('Seventeen initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('Seventeen didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SeventeenStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('Seventeen didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('Seventeen setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('Seventeen deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('Seventeen dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _setScrollNotification();
  }

  Widget _setScrollNotification() {
    return NotificationListener(
      onNotification: (notification) {
        switch (notification.runtimeType){
          case ScrollStartNotification:
            _scrollStart();
            break;
          case ScrollUpdateNotification:
            _scrollUpdate();
            break;
          case ScrollEndNotification:
            _scrollEnd();
            break;
          case OverscrollNotification:
            _scrollOver();
            break;
        }
        return true;
      },
      child: ListView.builder(
          padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
          physics: const ClampingScrollPhysics(), //重要
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
                title: set.initText2('$index', ColorValue.black, ColorValue.transParent, 20),
                subtitle: _setItem()
            );
          }),
    );
  }

  void _scrollStart(){
    setState(() { });
    _strScroll = '開始滑動';
  }

  void _scrollUpdate(){
    setState(() { });
    _strScroll = '正在滑動';
  }

  void _scrollEnd(){
    setState(() { });
    _strScroll = '滑動結束';
  }

  void _scrollOver(){
    setState(() { });
    _strScroll = '滑到邊界';
  }

  Widget _setItem() {
    return set.initText2('Notification Listener\n$_strScroll', ColorValue.black, ColorValue.transParent, 16);
  }

}