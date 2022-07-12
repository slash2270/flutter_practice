import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../tiktok/tiktokvideoview.dart';

Set set = Set();

class ThirtyFive extends StatelessWidget {
  const ThirtyFive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ThirtyFiveStateFul()
    );
  }
}

class ThirtyFiveStateFul extends StatefulWidget {
  const ThirtyFiveStateFul({Key? key}) : super(key: key);

  @override
  State<ThirtyFiveStateFul> createState() => ThirtyFiveStateFulState();
}

class ThirtyFiveStateFulState extends State<ThirtyFiveStateFul> with WidgetsBindingObserver {

  late Widget body;
  late List<String> items;
  late RefreshController _refreshController;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('ThirtyFive initState');
    }
    items = ["1", "2", "3", "4", "5", "6", "7", "8"];
    _refreshController = RefreshController(initialRefresh: false);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('ThirtyFive didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ThirtyFiveStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('ThirtyFive didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('ThirtyFive setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('ThirtyFive deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('ThirtyFive dispose');
    }
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length+1).toString());
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: BezierCircleHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode){
            if(mode==LoadStatus.idle){
              body = Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body = CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
              body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
          itemExtent: 100.0,
          itemCount: items.length,
        ),
      ),
    );
  }

}