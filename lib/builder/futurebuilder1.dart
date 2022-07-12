import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FutureBuilderWidget1 extends StatefulWidget {
  const FutureBuilderWidget1 ({Key? key}) : super(key: key);

  @override
  State<FutureBuilderWidget1> createState() => _FutureBuilderWidget1State();
}

class _FutureBuilderWidget1State extends State<FutureBuilderWidget1 > {

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('FutureBuilder1 build');
    }
    return FutureBuilder<String>(
      future: mockNetworkData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // 请求已结束
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // 请求失败，显示错误
            return Text("FutureBuilder1 Error: ${snapshot.error}");
          } else {
            // 请求成功，显示数据
            return Text("FutureBuilder1 Response: ${snapshot.data}");
          }
        } else {
          // 请求未结束，显示loading
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

Future<String> mockNetworkData() async { // 返回需要的資料型態
  return Future.delayed(const Duration(seconds: 3), () => '異步進程取得資料');
}