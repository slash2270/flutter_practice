import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/stream/streamhelper.dart';

class StreamBuilderWidget extends StatefulWidget {
  const StreamBuilderWidget ({Key? key}) : super(key: key);

  @override
  State<StreamBuilderWidget> createState() => _StreamBuilderState();
}

class _StreamBuilderState extends State<StreamBuilderWidget > {

  late StreamHelper _helper;

  @override
  void initState() {
    if (kDebugMode) {
      print('StreamBuilder initState');
    }
    _helper = StreamHelper();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('StreamBuilder setState');
    }
    _helper.stream;
    super.setState(fn);
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('StreamBuilder dispose');
    }
    _helper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('StreamBuilder build');
    }
    return StreamBuilder<dynamic>(
      stream: _helper.counter(), //
      initialData: _helper.state.count,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text('沒有Response');
          case ConnectionState.waiting:
            return const Text('等待數據');
          case ConnectionState.active:
            if(snapshot.data > 20){
              return const Text('Stream 已關閉');
            }else {
              return Text('次數: ${snapshot.data}');
            }
          case ConnectionState.done:
            return const Text('Stream 已關閉');
        }
        //return null; // unreachable
      },
    );
  }

}