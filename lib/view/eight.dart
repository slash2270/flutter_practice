import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/bean/eightbean.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Set set = Set();

class Eight extends StatelessWidget {
  const Eight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: EightContent());
  }
}

class EightContent extends StatefulWidget {
  const EightContent({Key? key}) : super(key: key);

  @override
  State<EightContent> createState() => EightState();
}

class EightState extends State<EightContent> with WidgetsBindingObserver, AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late ScrollController _scrollController;
  late List<EightBean> listEight, listItemCount;
  late bool isLoading, isList;
  late double value;
  late String text;
  late int i;

  @override
  bool get wantKeepAlive => false; // 是否需要缓存

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('Eight initState');
    }
    text = '';
    value = 0.0;
    isList = false;
    isLoading = true;
    listItemCount = [];
    _scrollController = ScrollController();
    _refresh();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('Eight didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant EightContent oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('Eight didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('Eight setState');
    }
    _setController();
    _setLoading();
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('Eight deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('Eight dispose');
    }
    super.dispose();
  }

  void _setController(){
    _scrollController.addListener(() { // 判断是否滑到底
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        isLoading = true;
        _loadMore('up');
      }
    });
  }

  void _setLoading() {
    if ((listItemCount.length * 5).toDouble() % 100.0 == 0) {
      isLoading = false;
      isList = true;
    }
  }

  void _getData() async {
    isLoading = true;
    listEight = [];

    var dio = Dio(BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 10000,
    ));
    final client = RestClient(dio);
    listEight = await client.getEightBean();
    if (kDebugMode) {
      print('Eight length -> ${listEight.length}');
    }

    _loadMore('down');
    isLoading = false;
  }

  Widget _itemView1(BuildContext context, int index) {
    return ListTile(
      //isThreeLine: true,//子item的是否为三行
      dense: false,
      leading: const Icon(Icons.accessibility),
      title: Text(
        text,
        maxLines: 5,
        style: const TextStyle(
          color: Colors.black,
          backgroundColor: Colors.transparent,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_right,
        color: Colors.green,
      ),
      //显示右侧的箭头，不显示则传null
      onTap: () {
        _itemClick(index);
      },
    );
  }

  void _itemClick(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Eight(),
            settings: RouteSettings(
              arguments: listItemCount[index],
            )));
  }

  void _loadMore(String action) {
    setState(() {
      if (listItemCount.isEmpty) {
        for (i = 0; i < 20; i++) {
          listItemCount.add(listEight[i]);
        }
      } else {
        int j = listItemCount.length;
        if (action == 'down') {
          for (i = j; i < j; i++) {
            listItemCount.add(listEight[i]);
          }
        } else {
          for (i = j; i < j + 20; i++) {
            listItemCount.add(listEight[i]);
          }
        }
      }
    });
    //await Future.delayed(const Duration(seconds: 0), () {});
  }

  Future<void> _refresh() async {
    _getData();
  }

  Widget _initCircular() {
    return SpinKitFadingCube(
      size: 50.0,
      //controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Colors.blueAccent.shade100 : Colors.purpleAccent.shade100,
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
            color: const Color.fromARGB(15, 15, 15, 15),
            padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
            child: Container(
              color: Colors.white,
              child: RefreshIndicator( //下拉刷新
                displacement: 50.0,
                child: listItemCount.isEmpty ? Center(child: _initCircular(),) : ListView.separated(
                  //primary: true,
                  controller: _scrollController,
                  itemCount: listItemCount.length,
                  itemBuilder: (context, index) {
                    text = '${listItemCount[index].id}\n${listItemCount[index].title}\n${listItemCount[index].body}';
                    return _itemView1(context, index);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 1,
                      color: Colors.green,
                    );
                  },
                ),
                onRefresh: () => _refresh(),
              ),
            ),
          ),
        );
  }

}
