import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/network/websocketdemo2.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/network/websocketdemo1.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../network/socketwidget.dart';

Set set = Set();

class TwentyThree extends StatelessWidget {
  const TwentyThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: set.initText('TwentyThree Page'),
      ),
      body: const SingleChildScrollView(
        child: TwentyThreeStateFul(),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class TwentyThreeStateFul extends StatefulWidget {
  const TwentyThreeStateFul({Key? key}) : super(key: key);

  @override
  State<TwentyThreeStateFul> createState() => TwentyThreeState();
}

class TwentyThreeState extends State<TwentyThreeStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('TwentyThree initState');
    }
    _setWebSocketChannel();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('TwentyThree didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant TwentyThreeStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('TwentyThree didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('TwentyThree setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('TwentyThree deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('TwentyThree dispose');
    }
    super.dispose();
  }

  _setWebSocketChannel() async{
    var channel = IOWebSocketChannel.connect(Uri.parse('ws://localhost:1234'));

    await channel.stream.listen((message) {
      channel.sink.add('received!');
      channel.sink.close(status.goingAway);
    });
  }

  // intl
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            WebSocketDemo1(),
            set.initSizedBox(20.0),
            WebSocketDemo2(),
            set.initSizedBox(20.0),
            SocketWidget(),
          ]),
    );
  }

  void getData() async{
    var url = "http://download.dcloud.net.cn/HBuilder.9.0.2.macosx_64.dmg";
    var savePath = "./example/HBuilder.9.0.2.macosx_64.dmg";
    await downloadWithChunks(url, savePath, onReceiveProgress: (received, total) {
      if (total != -1) {
        if (kDebugMode) {
          print("${(received / total * 100).floor()}%");
        }
      }
    });
  }

  /// Downloading by spiting as file in chunks
  Future downloadWithChunks(url, savePath, {required ProgressCallback onReceiveProgress,}) async {
    const firstChunkSize = 102;
    const maxChunk = 3;

    int total = 0;
    var dio = Dio();
    var progress = <int>[];

    createCallback(no) {
      return (int received, _) {
        progress[no] = received;
        if (onReceiveProgress != null && total != 0) {
          onReceiveProgress(progress.reduce((a, b) => a + b), total);
        }
      };
    }

    Future<Response> downloadChunk(url, start, end, no) async {
      progress.add(0);
      --end;
      return dio.download(
        url,
        savePath + "temp$no",
        onReceiveProgress: createCallback(no),
        options: Options(
          headers: {"range": "bytes=$start-$end"},
        ),
      );
    }

    Future mergeTempFiles(chunk) async {
      File f = File(savePath + "temp0");
      IOSink ioSink= f.openWrite(mode: FileMode.writeOnlyAppend);
      for (int i = 1; i < chunk; ++i) {
        File _f = File(savePath + "temp$i");
        await ioSink.addStream(_f.openRead());
        await _f.delete();
      }
      await ioSink.close();
      await f.rename(savePath);
    }

    Response response = await downloadChunk(url, 0, firstChunkSize, 0);
    if (response.statusCode == 206) {
      total = int.parse(response.headers.value(HttpHeaders.contentRangeHeader)!.split("/").last);
      int reserved = total - int.parse(response.headers.value(HttpHeaders.contentLengthHeader)!);
      int chunk = (reserved / firstChunkSize).ceil() + 1;
      if (chunk > 1) {
        int chunkSize = firstChunkSize;
        if (chunk > maxChunk + 1) {
          chunk = maxChunk + 1;
          chunkSize = (reserved / maxChunk).ceil();
        }
        var futures = <Future>[];
        for (int i = 0; i < maxChunk; ++i) {
          int start = firstChunkSize + i * chunkSize;
          futures.add(downloadChunk(url, start, start + chunkSize, i + 1));
        }
        await Future.wait(futures);
      }
      await mergeTempFiles(chunk);
    }
  }

}