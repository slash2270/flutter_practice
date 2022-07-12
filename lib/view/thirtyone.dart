
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class ThirtyOne extends StatelessWidget {
  const ThirtyOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThirtyOneStateFul();
  }
}

class ThirtyOneStateFul extends StatefulWidget {
  const ThirtyOneStateFul({Key? key}) : super(key: key);

  @override
  State<ThirtyOneStateFul> createState() => ThirtyOneState();
}

class ThirtyOneState extends State<ThirtyOneStateFul> with WidgetsBindingObserver {

  // 将handle 缓存
  late SliverOverlapAbsorberHandle handle;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('ThirtyOne initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('ThirtyOne didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ThirtyOneStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('ThirtyOne didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('ThirtyOne setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('ThirtyOne deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('ThirtyOne dispose');
    }
    super.dispose();
  }

  void onOverlapChanged(){
    // 打印 overlap length
    print(handle.layoutExtent);
  }

  @override
  Widget build(BuildContext context) {

    var fixedExtentList = SliverFixedExtentList(
      itemExtent: 50.0,
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          //创建列表项
          return Container(
            alignment: Alignment.center,
            color: Colors.purple[100 * (index % 9)],
            child: set.initText('list item $index'),
          );
        },
        childCount: 10,
      ),
    );

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          handle = NestedScrollView.sliverOverlapAbsorberHandleFor(context);
          //添加监听前先移除旧的
          handle.removeListener(onOverlapChanged);
          //overlap长度发生变化时打印
          handle.addListener(onOverlapChanged);
          return <Widget>[
            SliverOverlapAbsorber(
              handle: handle,
              sliver: SliverAppBar(
                title: set.initText('ThirtyOne Page'),
                floating: true,
                snap: true,
                // pinned: true,  // 放开注释，然后看日志
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    "images/ellen.jpeg",
                    fit: BoxFit.fill,
                  ),
                ),
                forceElevated: innerBoxIsScrolled,
              ),
            ),
          ];
        },
        body: LayoutBuilder(builder: (BuildContext context,cons) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverOverlapInjector(handle: handle),
              fixedExtentList,
            ],
          );
        }),
      ),
    );

  }

}