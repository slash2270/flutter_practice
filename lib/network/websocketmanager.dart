// @dart = 2.9

import 'dart:async';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum StatusEnum{
  connect,connecting,close,closing
}
class WebSocketManager{
  static WebSocketManager _singleton;

  WebSocketChannel channel;
  factory WebSocketManager() {
    return _singleton;
  }
  StreamController<StatusEnum> socketStatusController = StreamController<StatusEnum>();
  WebSocketManager._();
  static void init() async {
    if (_singleton == null) {
      _singleton = WebSocketManager._();
    }
  }
  StatusEnum isConnect=StatusEnum.close ;  //默认为未连接
  String _url="ws://echo.websocket.org";

  Future connect() async{
    if(isConnect==StatusEnum.close){
      isConnect=StatusEnum.connecting;
      socketStatusController.add(StatusEnum.connecting);
      channel=await IOWebSocketChannel.connect(Uri.parse(_url));
      isConnect=StatusEnum.connect;
      socketStatusController.add(StatusEnum.connect);
      return true;
    }

  }

  Future disconnect() async{
    if(isConnect==StatusEnum.connect){
      isConnect=StatusEnum.closing;
      socketStatusController.add(StatusEnum.closing);
      await channel.sink.close(3000,"主動關閉");
      isConnect=StatusEnum.close;
      socketStatusController.add(StatusEnum.close);

    }

  }

  bool send(String text){
    if(isConnect==StatusEnum.connect) {
      channel.sink.add(text);
      return true;
    }
    return false;
  }

  void printStatus(){
    if(isConnect==StatusEnum.connect){
      print("WebSocket 已連接");
    }else if(isConnect==StatusEnum.connecting){
      print("WebSocket 連接中");
    }else if(isConnect==StatusEnum.close){
      print("WebSocket 已關閉");
    }else if(isConnect==StatusEnum.closing){
      print("WebSocket 關閉中");
    }
  }

  void dispose(){
    socketStatusController.close();
    socketStatusController=null;
  }

}