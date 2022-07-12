import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class Four extends StatelessWidget {
  const Four({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: set.initText('Four Page'),
        ),
        body: FourContent()
    );
  }
}

class FourContent extends StatefulWidget {
  const FourContent({Key? key}) : super(key: key);

  @override
  State<FourContent> createState() => FourState();
}

class FourState extends State<FourContent> with WidgetsBindingObserver {

  bool isCheck = false, isCheckList = false, isSwitch = false, isSwitchList = false, isCupertino = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('initState Four');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('didChangeDependencies Four');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FourContent oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('didUpdateWidget Four');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('setState Four');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('deactivate Four');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('dispose Four');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      height: 1000,
      color: Colors.white,
      padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  //指定索引及固定列宽
                  0: FixedColumnWidth(100.0),
                  1: FixedColumnWidth(50.0),
                  2: FixedColumnWidth(180.0),
                },
                //設定表格樣式
                border: TableBorder.all(
                    color: Colors.black87,
                    width: 2.0,
                    style: BorderStyle.solid),
                children: const <TableRow>[
                  TableRow(
                    children: <Widget>[
                      Text('課程'),
                      Text('講師'),
                      Text('時間'),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      Text('刀法'),
                      Text('兵長'),
                      Text('每週 一～五 09:00~12:00'),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      Text('課程'),
                      Text('講師'),
                      Text('時間'),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      Text('立體機動裝置'),
                      Text('兵長'),
                      Text('每週 一～五 13:00~15:00'),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      Text('課程'),
                      Text('講師'),
                      Text('時間'),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      Text('槍法'),
                      Text('兵長'),
                      Text('每週 一～五 15:00~18:00'),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  //指定索引及固定列宽
                  0: FixedColumnWidth(100.0),
                  1: FixedColumnWidth(50.0),
                  2: FixedColumnWidth(180.0),
                }, //設定表格樣式
                border: TableBorder.all(
                    color: Colors.black87,
                    width: 2.0,
                    style: BorderStyle.solid),
                children: const <TableRow>[
                  TableRow(
                    children: <Widget>[
                      Icon(Icons.draw_outlined),
                      Icon(Icons.draw_rounded),
                      Icon(Icons.draw_sharp),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: AspectRatio(
                    aspectRatio: 1, // 宽高比
                    child: Image.asset('images/ellen_head.jpeg', fit: BoxFit.fill,)
                )
            ),
            Expanded(
              flex: 1,
              child: Checkbox(
                activeColor: Colors.blue,
                checkColor: Colors.white,
                value: isCheck,
                onChanged: (value) {
                  setState(() {
                    isCheck = value!;
                  });
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: CheckboxListTile(
                secondary: const Icon(Icons.alarm_on),
                title: set.initText('每天06:10 響鈴'),
                subtitle: set.initText('12:00後 響鈴'),
                activeColor: Colors.blue,
                checkColor: Colors.white,
                selected: isCheckList,
                selectedTileColor: Colors.blue,
                value: isCheckList,
                onChanged: (value) {
                  setState(() {
                    isCheckList = value!;
                  });
                },
              ),
            ),
            Expanded(
                flex: 1,
                child: Switch(
                  //当前状态
                  value: isSwitch,
                  // 激活时原点颜色
                  activeColor: Colors.blue,
                  inactiveTrackColor: Colors.blue.shade50,
                  onChanged: (value) {
                    //重新构建页面
                    setState(() {
                      isSwitch = value;
                    });
                  },
                )),
            Expanded(
                flex: 1,
                child: SwitchListTile(
                  secondary: const Icon(Icons.shutter_speed),
                  title: set.initText('硬件加速'),
                  activeColor: Colors.blue,
                  selected: isSwitchList,
                  selectedTileColor: Colors.blue,
                  inactiveTrackColor: Colors.blue.shade50,
                  value: isSwitchList,
                  onChanged: (value) {
                    setState(() {
                      isSwitchList = value;
                    });
                  },
                ),
            ),
            Expanded(
              flex: 1,
              child: CupertinoSwitch(
                activeColor: Colors.blue,
                value: isCupertino,
                onChanged: (value) {
                  setState(() {
                    isCupertino = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }

}
