import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';

class SocketWidget extends StatefulWidget {
  const SocketWidget({Key? key}) : super(key: key);

  @override
  State<SocketWidget> createState() => _SocketWidgetState();
}

class _SocketWidgetState extends State<SocketWidget> {
  late Set set;

  @override
  void initState() {
    set = Set();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _request(),
      builder: (context, snapShot) {
        return Column(
          children: [
            set.initText2('SocketWidget 請求', Colors.black, Colors.transparent, 24),
            set.initText2(snapShot.data.toString(), Colors.black, Colors.transparent, 16),
          ],
        );
      },
    );
  }

  /// 可以看到响应内容分两个部分，第一部分是响应头，第二部分是响应体，服务端可以根据请求信息动态来输出响应体。
  /// 由于本示例请求头比较简单，所以响应体和浏览器中访问的会有差别，
  /// 读者可以补充一些请求头(如user-agent)来看看输出的变化。

  _request() async {
    //建立连接
    var socket = await Socket.connect("baidu.com", 80);
    //根据http协议，发起 Get请求头
    socket.writeln("GET / HTTP/1.1");
    socket.writeln("Host:baidu.com");
    socket.writeln("Connection:close");
    socket.writeln();
    await socket.flush(); //发送
    //读取返回内容，按照utf8解码为字符串
    String _response = await utf8.decoder.bind(socket).join();
    await socket.close();
    return _response;
  }
}