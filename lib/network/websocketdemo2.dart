import 'package:flutter/material.dart';
import 'package:flutter_practice/network/websocketmanager.dart';
import 'package:flutter_practice/set.dart';

class WebSocketDemo2 extends StatefulWidget {

  @override
  _WebSocketDemo2State createState() => _WebSocketDemo2State();
}

class _WebSocketDemo2State extends State<WebSocketDemo2> {

  late Set _set;
  late ElevatedButton _elevatedButton;

  @override
  void initState() {
    super.initState();
    //初始化
    _set = Set();
    WebSocketManager.init();
  }

  @override
  void dispose() {
    WebSocketManager().dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _elevatedButton = ElevatedButton(
              onPressed:() => _send() ,
              child: _set.initText("傳送"),
            ),
            _elevatedButton = ElevatedButton(
              onPressed:() => _open() ,
              child: _set.initText("打開WebSocket連接"),
            ),
            _elevatedButton = ElevatedButton(
              onPressed:() => _close() ,
              child: _set.initText("關閉WebSocket連接"),
            ),
            _elevatedButton = ElevatedButton(
              onPressed:() => _reconnect() ,
              child: _set.initText("重新連接WebSocket"),
            ),
            StreamBuilder<StatusEnum>(
              builder: (BuildContext context, AsyncSnapshot<StatusEnum> snapshot) {
                if (snapshot.data==StatusEnum.connect){
                  return StreamBuilder(
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot2) {
                      if(snapshot2.hasData){
                        return Container(
                          child: _set.initText("收到的消息: ${snapshot2.data}"
                          ),
                        );
                      }else if(snapshot2.hasError){//WebSocket发生错误 (这里未做测试)
                        _reconnect();//重连
                        return _set.initText("重新連接");
                      }
                      return _set.initText("已連接,未接收數據！");
                    },
                    stream: WebSocketManager().channel.stream,
                  );
                }else if(snapshot.data==StatusEnum.connecting){
                  return _set.initText("連接中");
                }else if(snapshot.data==StatusEnum.close){
                  return _set.initText("已關閉");
                }else if(snapshot.data==StatusEnum.closing){
                  return _set.initText("關閉中");
                }
                return _set.initText('');
              },
              initialData: StatusEnum.close,
              stream:WebSocketManager().socketStatusController.stream,
            )
          ],
    );
  }
  _open()async {
    await WebSocketManager().connect();
  }
  _close() async{
    await WebSocketManager().disconnect();
  }

  int i=0;
  _send() {
    WebSocketManager().send("Hello World${i+=1}");
  }

  _reconnect() async{
    await _close();
    await _open();
  }
}