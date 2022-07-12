import 'dart:core';
import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/bloc/bloc2.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/stream/streamhelper.dart';
import 'package:flutter_practice/value/colorvalue.dart';

Set set = Set();

class Eleven extends StatelessWidget {
  const Eleven({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: set.initText('Eleven Page'),
        ),
        body: const ElevenStateFul()
    );
  }
}

class ElevenStateFul extends StatefulWidget {
  const ElevenStateFul({Key? key}) : super(key: key);

  @override
  State<ElevenStateFul> createState() => ElevenState();
}

class ElevenState extends State<ElevenStateFul> with WidgetsBindingObserver {
  String string = '';
  int _countNumber = 0;
  late StreamHelper _helper;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('Eleven initState');
    }
    _helper = StreamHelper();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('Eleven didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ElevenStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('Eleven didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('Eleven setState');
    }
    _helper.stream;
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('Eleven deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('Eleven dispose');
    }
    _helper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: set.initEdgeInsets(10.0, 20.0, 10.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Expanded(
              flex: 1,
              child: Text('Thread Control'),
            ),
            Expanded(
              flex: 9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(),
                        ),
                        set.initText2('Isolate', ColorValue.black, ColorValue.transParent, 24),
                        set.initText(_countNumber.toString()),
                        FlatButton(
                            onPressed: () async {
                              _countNumber = await compute(countEven, 1000000000);
                              setState(() {});
                            },
                            child: const Text(
                              'compute',
                            )),
                        FlatButton(
                            onPressed: () async {
                              _countNumber = await isolateCountEven(1000000000);
                              setState(() {});
                            },
                            child: const Text(
                              'isolate',
                            )),
                        FlatButton(
                            onPressed: () async {
                              _countNumber = 0;
                              setState(() {});
                            },
                            child: const Text(
                              '歸零',
                            )),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(),
                        ),
                        set.initText2('StreamBuilder', ColorValue.black, ColorValue.transParent, 24),
                        StreamBuilder(
                          // 使用 StreamBuilder 显示和更新 UI
                          stream: _helper.stream,
                          initialData: _helper.state.count,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return Text('Done', style: Theme.of(context).textTheme.bodyText2,);
                            }
                            return Text('${snapshot.data}', style: Theme.of(context).textTheme.bodyText2,);
                          },
                        ),
                        FlatButton(
                            onPressed: () async {
                              _helper.increment();
                              setState(() {});
                            },
                            child: const Text(
                              'increment',
                            )),
                        FlatButton(
                            onPressed: () async {
                              _helper.decrement();
                              setState(() {});
                            },
                            child: const Text(
                              'decrement',
                            )),
                        FlatButton(
                            onPressed: () async {
                              _helper.state.count = 0;
                              setState(() {});
                            },
                            child: const Text(
                              '歸零',
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static int countEven(int num) {
    // 计算偶数的个数
    int countLoop = 0;
    while (num > 0) {
      if (num % 2 == 0) {
        countLoop++;
      }
      num--;
    }
    return countLoop;
  }

  Future<dynamic> isolateCountEven(int num) async {
    final response = ReceivePort();
    await Isolate.spawn(countEvent2, response.sendPort);
    final sendPort = await response.first;
    final answer = ReceivePort();
    sendPort.send([answer.sendPort, num]);
    return answer.first;
  }

  static void countEvent2(SendPort port) {
    final rPort = ReceivePort();
    port.send(rPort.sendPort);
    rPort.listen((message) {
      final send = message[0] as SendPort;
      final n = message[1] as int;
      send.send(countEven(n));
    });
  }

}