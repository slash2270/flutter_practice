import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';

import '../cache/keepalivewrapper.dart';

Set set = Set();

class Seven extends StatelessWidget {
  const Seven({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SevenStateFul());
  }
}

class SevenStateFul extends StatefulWidget {
  const SevenStateFul({Key? key}) : super(key: key);

  @override
  State<SevenStateFul> createState() => SevenState();
}

class SevenState extends State<SevenStateFul> with WidgetsBindingObserver {

  var data = <String>[];
  int counter = 5;
  late GlobalKey<AnimatedListState> globalKey;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('initState Seven');
    }
    globalKey = GlobalKey<AnimatedListState>();
    for (var i = 0; i < counter; i++) {
      data.add('${i + 1}');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('didChangeDependencies Seven');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SevenStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('didUpdateWidget Seven');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('setState Seven');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('deactivate Seven');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('dispose Seven');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: set.initEdgeInsets(10.0, 20.0, 10.0, 20.0),
        child: data.isEmpty ? const CircularProgressIndicator(): Stack(
          children: [
            AnimatedList(
              key: globalKey,
              initialItemCount: data.length,
              itemBuilder: (BuildContext context, int index, Animation<double> animation,) {
                return KeepAliveWrapper(
                  child: FadeTransition(
                  opacity: animation,
                  child: buildItem(context, index),
                ));
                //添加列表项时会执行渐显动画
              },
            ),
            buildAddBtn(),
          ],
        ),
      ),
    );
  }

  // 创建一个 “+” 按钮，点击后会向列表中插入一项
  Widget buildAddBtn() {
    return Positioned(
      child: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            // 添加一个列表项
            data.add('${++counter}');
            // 告诉列表项有新添加的列表项
            globalKey.currentState!.insertItem(data.length - 1);
          });
          if (kDebugMode) {
            print('Seven List++ $counter');
          }
        },
      ),
      bottom: 30,
      left: 0,
      right: 0,
    );
  }

  // 构建列表项
  Widget buildItem(context, index) {
    String char = data[index];
    return ListTile(
      // 数字不会重复，所以作为Key
      key: ValueKey(char),
      title: Text(char),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        // 点击时删除
        onPressed: () => onDelete(context, index),
      ),
    );
  }

  void onDelete(context, index) {
    setState(() {
      globalKey.currentState!.removeItem(
        index, (context, animation) {
          // 删除过程执行的是反向动画，animation.value 会从1变为0
          var item = buildItem(context, index);
          if (kDebugMode) {
            print('Seven List-- ${data[index]}');
          }
          data.removeAt(index);
          // 删除动画是一个合成动画：渐隐 + 缩小列表项告诉
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              //让透明度变化的更快一些
              curve: const Interval(0.5, 1.0),
            ),
            // 不断缩小列表项的高度
            child: SizeTransition(
              sizeFactor: animation,
              axisAlignment: 0.0,
              child: item,
            ),
          );
        },
        duration: const Duration(milliseconds: 200), // 动画时间为 200 ms
      );
    });
  }

}