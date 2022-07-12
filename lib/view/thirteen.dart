import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class Thirteen extends StatelessWidget {
  const Thirteen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ThirteenStateFul();
  }
}

class ThirteenStateFul extends StatefulWidget {
  const ThirteenStateFul({Key? key}) : super(key: key);

  @override
  State<ThirteenStateFul> createState() => ThirteenState();
}

class ThirteenState extends State<ThirteenStateFul> with WidgetsBindingObserver{

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('Thirteen initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('Thirteen didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ThirteenStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('Thirteen didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('Thirteen setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('Thirteen deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('Thirteen dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _tabs = <String>['child1', 'child2', 'child3'];
    // 构建 tabBar
    return DefaultTabController(
      length: _tabs.length, // This is the number of tabs.
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: const Text('Thirteen Page'),
                  floating: true,
                  snap: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.orangeAccent.shade200,
                    indicatorColor: Colors.orangeAccent.shade400,
                    tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: _tabs.map((String name) {
              return Builder(
                builder: (BuildContext context) {
                  return CustomScrollView(
                    key: PageStorageKey<String>(name),
                    slivers: <Widget>[
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(8.0),
                        sliver: SliverFixedExtentList(
                          itemExtent: 50.0,
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              //创建列表项
                              return Container(
                                alignment: Alignment.center,
                                color: Colors.yellow[100 * (index % 10)],
                                child: Text('list item $index'),
                              );
                            },
                            childCount: 20,
                          ),
                        )
                      ),
                    ],
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

}