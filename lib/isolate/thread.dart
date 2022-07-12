import 'dart:isolate';

import '../network/networkclient.dart';

class Thread{

  static setSentPort(SendPort sendPort) async{ // isolate的绑定方法
    final receivePort = ReceivePort(); //绑定
    sendPort.send(receivePort.sendPort);
    await for (var msg in receivePort) { // 监听外界调用
      //获取数据并解析
      String msgUrl = msg[0];
      SendPort msgPort =msg[1];
      NetWorkClient netWorkClient = NetWorkClient();
      List msgList = await netWorkClient.getDio(msgUrl);
      //List list = await netWorkClient.getHttp(Constants.apiSix);
      msgPort.send(msgList); // 回调返回值给调用者
    }
    receivePort.close();
    /*receivePort.listen((message){
        //获取数据并解析
        final msgList = message[0] as List;
        final msgPort = message[1] as SendPort;
        //返回结果
        msgPort.send(msgList);
    }*/
  }

  static Future sendReceive(SendPort sendPort, String url) { // 创建自己的监听port，并且向新isolate发送消息
    ReceivePort receivePort = ReceivePort();
    sendPort.send([url, receivePort.sendPort]); // 发送数据
    return receivePort.first;  // 接收到返回值，返回给调用者
  }

}