import 'package:flutter/material.dart';
import 'package:flutter_practice/animation/animatedimagewidget.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketDemo1 extends StatefulWidget {
  const WebSocketDemo1({Key? key}) : super(key: key);

  @override
  _WebSocketWidgetState createState() => _WebSocketWidgetState();
}

class _WebSocketWidgetState extends State<WebSocketDemo1> {
  late TextEditingController _controller;
  late IOWebSocketChannel channel;
  String _text = "";

  @override
  void initState() {
    _controller = TextEditingController();
    // 创建webSocket连接
    channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        set.initText2('WebSocketWidget 服務器', Colors.black, Colors.transparent, 24),
        set.initText2("WebSocket(內容回傳)", Colors.green, Colors.transparent, 20),
        Form(
          child: TextFormField(
            controller: _controller,
            decoration: const InputDecoration(labelText: '傳送訊息...'),
          ),
        ),
        StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            //网络不通会走到这
            if (snapshot.hasError) {
              _text = "網路不通...";
            } else if (snapshot.hasData) {
              _text = "echo: " + snapshot.data.toString();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: set.initText2(_text, Colors.green, Colors.transparent, 20),
            );
          },
        ),
        SizedBox.fromSize(
          size: const Size(100, 100),
          child: ClipOval(
            child: Material(
              color: Colors.amberAccent,
              child: InkWell(
                splashColor: Colors.white,
                onTap: _sendMessage,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    set.initIcon2(Icons.send, 24, Colors.blue),
                    set.initText2('Send\nMessage', Colors.black, Colors.transparent, 18)// <-- Icon
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}