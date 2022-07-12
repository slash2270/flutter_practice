import 'dart:core';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../backpress/willpopscope.dart';
import '../bean/sixbean.dart';
import '../isolate/thread.dart';
import '../utils/constants.dart';

Set set = Set();

class Six extends StatelessWidget {
  const Six({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SixStateFul());
  }
}

class SixStateFul extends StatefulWidget {
  const SixStateFul({Key? key}) : super(key: key);

  @override
  State<SixStateFul> createState() => SixState();
}

class SixState extends State<SixStateFul> with WidgetsBindingObserver, TickerProviderStateMixin {
  late ScrollController _scrollController;
  late List<SixBean> listSix, listItemCount;
  late bool isLoading, isList;
  late double value;
  late String text;
  late int i;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    print('initState Six');
    text = '';
    value = 0.0;
    isList = false;
    isLoading = true;
    listItemCount = [];
    _scrollController = ScrollController(); // 监听滑动
    _refresh();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    print('didChangeDependencies Six');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SixStateFul oldWidget) {
    // 元件發生變化
    print('didUpdateWidget Six');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    print('setState Six');
    _setController();
    _setLoading();
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    print('deactivate Six');
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    print('dispose Six');
    _scrollController.dispose();
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
    listSix = [];

    ReceivePort receivePort =ReceivePort(); // 通过spawn新建一个isolate，并绑定静态方法
    await Isolate.spawn(Thread.setSentPort, receivePort.sendPort); // 开始创建isolate,Isolate.spawn函数是isolate.dart里的代码,_isolate是我们自己实现的函数
    SendPort sendPort = await receivePort.first; // 获取新isolate的监听port
    receivePort.close();
    List list = await Thread.sendReceive(sendPort, Constants.apiPhotos); // 调用sendReceive自定义方法
    listSix = list.map((dynamic value) => SixBean.fromJson(value)).toList();

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

  Widget _itemView2(BuildContext context, int index) {
    /*if (kDebugMode) {
      print('Six list index -> $index');
    }*/
    SixBean sixBean = listSix[index];
    //设置分割线
    //if (index.isOdd) return const Divider(height: 10.0);
    return Container(
      padding: set.initEdgeInsets(0, 10.0, 0, 0.0),
      child: Column(
        children: <Widget>[
          Text('${sixBean.id}', style: const TextStyle(fontSize: 15.0)),
          Text(sixBean.title, style: const TextStyle(fontSize: 15.0)),
          Center(
            heightFactor: 4.0,
            child: Text(sixBean.content, style: const TextStyle(fontSize: 17.0)),
          )
        ],
      ),
    );
  }

  void _itemClick(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Six(),
            settings: RouteSettings(
              arguments: listItemCount[index],
            )));
  }

  void _loadMore(String action) {
    setState(() {
      if (listItemCount.isEmpty) {
        for (i = 0; i < 20; i++) {
          listItemCount.add(listSix[i]);
        }
      } else {
        int j = listItemCount.length;
        if (action == 'down') {
          for (i = j; i < j; i++) {
            listItemCount.add(listSix[i]);
          }
        } else {
          for (i = j; i < j + 20; i++) {
            listItemCount.add(listSix[i]);
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
    return SpinKitFadingCircle(
        //controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Colors.yellowAccent.shade100 : Colors.greenAccent.shade100,
            ),
          );
        }
    );
  }

  double _circularValue() {
    setState(() {
      value = (listItemCount.length * 5).toDouble() / 100.0;
    });
    return value;
  }

  @override
  Widget build(BuildContext context) {
    /*if (kDebugMode) {
      print('Six listItemCount length1 -> ${listItemCount.length}');
    }*/
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(15, 15, 15, 15),
        padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              RefreshIndicator( //下拉刷新
                displacement: 50.0,
                child: listItemCount.isEmpty ? Center(child: _initCircular(),) : ListView.separated(
                  //primary: true,
                  controller: _scrollController,
                  itemCount: listItemCount.length,
                  itemBuilder: (context, index) {
                    if(index % 2 == 0){
                      return _itemView2(context, index);
                    }else {
                      text = '${listItemCount[index].id}\n${listItemCount[index].title}\n${listItemCount[index].content}';
                      return _itemView1(context, index);
                    }
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
              const WillPopScopeWidget()
            ],
          ),
        ),
      ),
    );
  }

}